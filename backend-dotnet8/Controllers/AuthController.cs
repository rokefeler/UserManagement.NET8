using backend_dotnet8.Core.Constants;
using backend_dotnet8.Core.Dtos.Auth;
using backend_dotnet8.Core.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace backend_dotnet8.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : Controller
    {
        private readonly IAuthService _authService;

        public AuthController(IAuthService authService)
        {
            _authService = authService;
        }

        /// <summary>
        /// Seed Roles to DB
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        [Route("seed-roles")]
        public async Task<IActionResult> SeedRoles()
        {
            var seedResult = await _authService.SeedRolesAsync();
            return StatusCode(seedResult.StatusCode, seedResult.Message);
        }

        /// <summary>
        /// Register new user
        /// </summary>
        /// <param name="registerDto"></param>
        /// <returns></returns>
        [HttpPost]
        [Route("register")]
        public async Task<IActionResult> Register([FromBody] RegisterDto registerDto)
        {
            var registerResult = await _authService.RegisterAsync(registerDto);
            return StatusCode(registerResult.StatusCode, registerResult.Message);
        }

        /// <summary>
        /// Login user
        /// </summary>
        /// <param name="loginDto"></param>
        /// <returns></returns>
        [HttpPost]
        [Route("login")]
        public async Task<ActionResult<LoginServiceResponseDto>> Login([FromBody] LoginDto loginDto)
        {
            var loginResult = await _authService.LoginAsync(loginDto);
            if(loginResult is null)
            {
                return Unauthorized("Your credentials are invalid. Please contact to an Admin");
            }
            return Ok(loginResult);
        }

        //Route -> Update User Roles
        //An Owner can change everything
        //An Admin can change just User to Manager or reverse
        //Manager and User Roles don't have access to this Route
        [HttpPost]
        [Route("update-role")]
        [Authorize(Roles =StaticUserRoles.ADMIN)]
        public async Task<IActionResult> UpdateRole([FromBody] UpdateRoleDto updateRoleDto)
        {
            var updateRoleResult = await _authService.UpdateRoleAsync(User, updateRoleDto);
            if(updateRoleResult.IsSuccess)
            {
                return Ok(updateRoleResult.Message);
            }
            return StatusCode(updateRoleResult.StatusCode, updateRoleResult.Message);
        }

        /// <summary>
        /// Route - getting data of a user from it's JWT
        /// </summary>
        /// <param name="token"></param>
        /// <returns></returns>
        [HttpPost]
        [Route("me")]
        public async Task<ActionResult<LoginServiceResponseDto>> Me([FromBody] MeDto token)
        {
            try
            {
                var meResult = await _authService.MeAsync(token);
                if(meResult is not null)
                    return Ok(meResult);
                return Unauthorized("InvalidToken");
            }catch(Exception ex)
            {
                return Unauthorized("InvalidToken");
            }
        }


        /// <summary>
        /// Route List of all users with details
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        [Route("users")]
        public async Task<ActionResult<IEnumerable<UserInfoResult>>> GetUsersList()
        {
            var userList = await _authService.GetUsersListAsync();
            return Ok(userList);
        }

        //Route -> Get a User By UserName
        [HttpGet]
        [Route("users/{userName}")]
        public async Task<ActionResult<UserInfoResult>> GetUserDetailsByUserName([FromRoute] string userName)
        {
            var user = await _authService.GetUserDetailsByUserNameAsync(userName);
            if(user is not null)
                return Ok(user);

            return NotFound("UserName not found");
        }

        /// <summary>
        /// Get List of all usernames for send message
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        [Route("usernames")]
        public async Task<ActionResult<IEnumerable<string>>> GetUserNamesList()
        {
            var result = await _authService.GetUsernamesListAsync();
            return Ok(result);
        }
    }
}
