using backend_dotnet8.Core.Constants;
using backend_dotnet8.Core.Dtos.Auth;
using backend_dotnet8.Core.Dtos.General;
using backend_dotnet8.Core.Entities;
using backend_dotnet8.Core.Interfaces;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace backend_dotnet8.Core.Services
{
    public class AuthService : IAuthService
    {
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly ILogService _logService;
        private readonly IConfiguration _configuration;

        public AuthService(UserManager<ApplicationUser> userManager, 
                RoleManager<IdentityRole> roleManager, 
                ILogService logService, IConfiguration configuration)
        {
            _userManager = userManager;
            _roleManager = roleManager;
            _logService = logService;
            _configuration = configuration;
        }

        #region GetUserDetailsByUserNameAsync
        public async Task<UserInfoResult?> GetUserDetailsByUserNameAsync(string userName)
        {
            var user = await _userManager.FindByNameAsync(userName);
            if(user is null)
                return null;

            var roles = await _userManager.GetRolesAsync(user);
            var userInfo = GenerateUserInfoObject(user, roles);
            return userInfo;
        }
        #endregion

        #region GetUsernamesListAsync
        public async Task<IEnumerable<string>> GetUsernamesListAsync()
        {
            var userNames = await _userManager.Users
                .Select(u => u.UserName)
                .ToListAsync();
            return userNames;
        }
        #endregion

        #region GetUsersListAsync
        public async Task<IEnumerable<UserInfoResult>> GetUsersListAsync()
        {
            var users = await _userManager.Users.ToListAsync();

            var userInfoResults = new List<UserInfoResult>();
            foreach (var user in users)
            {
                var roles = await _userManager.GetRolesAsync(user);
                var userInfo = GenerateUserInfoObject(user, roles);
                userInfoResults.Add(userInfo);
            }
            return userInfoResults;
        }
        #endregion

        #region LoginAsync

        public async Task<LoginServiceResponseDto?> LoginAsync(LoginDto loginDto)
        {
            //FInd user with username
            var user = await _userManager.FindByNameAsync(loginDto.UserName);
            if (user is null)
                return null;

            //check password
            var isPasswordValid = await _userManager.CheckPasswordAsync(user, loginDto.Password);
            if(!isPasswordValid)
                return null;

            //return Token and userInfo to Front-end
            var newToken = await GenerateJWTTokenAsync(user);
            var roles = await _userManager.GetRolesAsync(user);
            var userInfo = GenerateUserInfoObject(user,roles);

            await _logService.SaveNewLog(loginDto.UserName, "New Login");

            return new LoginServiceResponseDto()
            {
                NewToken = newToken,
                UserInfo = userInfo
            };
        }
        #endregion

        #region
        private async Task<string> GenerateJWTTokenAsync(ApplicationUser user)
        {
            var userRoles = await _userManager.GetRolesAsync(user);
            var authClaims = new List<Claim>
            {
                new Claim(ClaimTypes.Name, user.UserName),
                new Claim(ClaimTypes.NameIdentifier, user.Id),
                new Claim("FirstName", user.FirstName),
                new Claim("LastName", user.LastName),
            };
            
            foreach(var userRole in userRoles)
            {
                authClaims.Add(new Claim(ClaimTypes.Role, userRole));
            }

            var authSecret = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["JWT:Secret"]));
            var siginCredentials = new SigningCredentials(authSecret, SecurityAlgorithms.HmacSha256);

            var tokenObject = new JwtSecurityToken(
                issuer: _configuration["JWT:ValidIssuer"],
                audience: _configuration["JWT:ValidAudience"],
                notBefore: DateTime.Now,
                expires: DateTime.Now.AddMinutes(30),
                claims: authClaims,
                signingCredentials: siginCredentials
                );

            string token = new JwtSecurityTokenHandler().WriteToken(tokenObject);
            return token;
        }
        #endregion

        #region GenerateUserInfoObject
        private UserInfoResult GenerateUserInfoObject(ApplicationUser user, IEnumerable<string> roles)
        {
            return new UserInfoResult()
            {
                Id = user.Id,
                FirstName = user.FirstName,
                LastName = user.LastName,
                UserName = user.UserName,
                Email = user.Email,
                CreatedAt = user.CreatedAt,
                Roles = roles,
            };
        }
        #endregion

        #region MeAsync
        public async Task<LoginServiceResponseDto?> MeAsync(MeDto meDto)
        {
            var handler = new JwtSecurityTokenHandler().ValidateToken(meDto.Token, new TokenValidationParameters()
            {
                ValidateIssuer = true,
                ValidateAudience = true,
                ValidIssuer = _configuration["JWT:ValidIssuer"],
                ValidAudience = _configuration["JWT:ValidAudience"],
                IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["JWT:Secret"])),
            }, out SecurityToken securityToken);

            var decodedUserName = handler.Claims.First(x => x.Type == ClaimTypes.Name).Value;
            if(decodedUserName is null)
                return null;

            var user = await _userManager.FindByNameAsync(decodedUserName);
            if(user is null)
                return null;

            var newToken = await GenerateJWTTokenAsync(user);
            var roles = await _userManager.GetRolesAsync(user);
            var userInfo = GenerateUserInfoObject(user, roles);
            await _logService.SaveNewLog(user.UserName, "New Token Generated");

            return new LoginServiceResponseDto()
            {
                NewToken = newToken,
                UserInfo = userInfo
            };
        }
        #endregion

        #region RegisterAsync
        public async Task<GeneralServiceResponseDto> RegisterAsync(RegisterDto registerDto)
        {
            var isExistsUser = await _userManager.FindByNameAsync(registerDto.UserName);
            if(isExistsUser is not null)
            {
                return new GeneralServiceResponseDto()
                {
                    IsSuccess = false,
                    StatusCode = 409,
                    Message = "User already exists"
                };
            }

            var newUser = new ApplicationUser() { 
                FirstName = registerDto.FirstName, 
                LastName = registerDto.LastName, 
                UserName = registerDto.UserName,
                Email = registerDto.Email,
                Address = registerDto.Address,
                SecurityStamp = Guid.NewGuid().ToString(),
            };
            
            var createuserResul = await _userManager.CreateAsync(newUser, registerDto.Password);
            if (!createuserResul.Succeeded)
            {
                var errorString = "User Creation failed because";
                foreach (var error in createuserResul.Errors)
                {
                    errorString += " # " + error.Description;
                }

                return new GeneralServiceResponseDto()
                {
                    IsSuccess = false,
                    StatusCode = 400,
                    Message = errorString
                };
            }

            //Add a Default USER Role to all users
            await _userManager.AddToRoleAsync(newUser, StaticUserRoles.USER);
            await _logService.SaveNewLog(newUser.UserName, $"{newUser.UserName} has been registered");
            return new GeneralServiceResponseDto()
            {
                IsSuccess = true,
                StatusCode = 201,
                Message = $"{newUser.UserName} has been created successfully"
            };
        }
        #endregion

        #region SeedRolesAsync
        public async Task<GeneralServiceResponseDto> SeedRolesAsync()
        {
            bool isOwnerRoleExists = await _roleManager.RoleExistsAsync(StaticUserRoles.OWNER);
            bool isAdminRoleExists = await _roleManager.RoleExistsAsync(StaticUserRoles.ADMIN);
            bool isManagerleExists = await _roleManager.RoleExistsAsync(StaticUserRoles.MANAGER);
            bool isUserRoleExists = await _roleManager.RoleExistsAsync(StaticUserRoles.USER);

            if(isOwnerRoleExists && isAdminRoleExists && isManagerleExists && isUserRoleExists)
                return new GeneralServiceResponseDto()
                {
                    IsSuccess = true,
                    Message = "Roles Seeding is Already Done",
                    StatusCode = 200
                };
            await _roleManager.CreateAsync(new IdentityRole(StaticUserRoles.OWNER));
            await _roleManager.CreateAsync(new IdentityRole(StaticUserRoles.ADMIN));
            await _roleManager.CreateAsync(new IdentityRole(StaticUserRoles.MANAGER));
            await _roleManager.CreateAsync(new IdentityRole(StaticUserRoles.USER));

            return new GeneralServiceResponseDto()
            {
                IsSuccess = true,
                StatusCode = 201,
                Message = "Roles Seeded Successfully"
            };
        }
        #endregion

        #region UpdateRoleAsync
        public async Task<GeneralServiceResponseDto> UpdateRoleAsync(ClaimsPrincipal User, UpdateRoleDto updateRoleDto)
        {
            var user = await _userManager.FindByNameAsync(updateRoleDto.UserName);
            if (user is null)
            {
                return new GeneralServiceResponseDto()
                {
                    IsSuccess = false,
                    StatusCode = 404,
                    Message = "Invalid UserName, User Not Found"
                };
            }

            var userRoles = await _userManager.GetRolesAsync(user);
            // Sólo el PROPIETARIO y el ADMIN pueden actualizar roles
            if (User.IsInRole(StaticUserRoles.ADMIN))
            {
                //user is admin
                if (updateRoleDto.NewRole == Enums.RoleType.USER || updateRoleDto.NewRole == Enums.RoleType.MANAGER)
                {
                    //admin can change the role of everyone except for owners and admins
                    if (userRoles.Any(q => q == StaticUserRoles.OWNER || q == StaticUserRoles.ADMIN))
                    {
                        return new GeneralServiceResponseDto()
                        {
                            IsSuccess = false,
                            StatusCode = 403,
                            Message = "No tienes permiso para cambiar el rol de este usuario."
                        };
                    }
                    else
                    {
                        await _userManager.RemoveFromRolesAsync(user, userRoles);
                        await _userManager.AddToRoleAsync(user, updateRoleDto.NewRole.ToString());
                        await _logService.SaveNewLog(updateRoleDto.UserName, $"{updateRoleDto.UserName} has been updated to {updateRoleDto.NewRole}");
                        return new GeneralServiceResponseDto()
                        {
                            IsSuccess = true,
                            StatusCode = 200,
                            Message = $"{updateRoleDto.UserName} has been updated to {updateRoleDto.NewRole}"
                        };
                    }
                } //fin de if (updateRoleDto.NewRole == Enums.RoleType.USER || ...

                else
                {
                    return new GeneralServiceResponseDto()
                    {
                        IsSuccess = false,
                        StatusCode = 403,
                        Message = "No tienes permiso para cambiar el rol de este usuario."
                    };
                }
            }
            else //si no is ADMIN
            {
                //user is owner
                if(userRoles.Any(q=>q.Equals(StaticUserRoles.OWNER)))
                {
                    return new GeneralServiceResponseDto()
                    {
                        IsSuccess = false,
                        StatusCode = 403,
                        Message = "No tienes permiso para cambiar el rol de este usuario."
                    };
                }
                else
                {
                    await _userManager.RemoveFromRolesAsync(user, userRoles);
                    await _userManager.AddToRoleAsync(user, updateRoleDto.NewRole.ToString());
                    await _logService.SaveNewLog(updateRoleDto.UserName, $"{updateRoleDto.UserName} has been updated to {updateRoleDto.NewRole}");

                    return new GeneralServiceResponseDto()
                    {
                        IsSuccess = true,
                        StatusCode = 200,
                        Message = $"{updateRoleDto.UserName} has been updated to {updateRoleDto.NewRole}"
                    };
                }
            }
        }
        #endregion
    }
}
