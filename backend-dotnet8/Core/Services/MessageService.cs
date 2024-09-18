using backend_dotnet8.Core.DbContext;
using backend_dotnet8.Core.Dtos.General;
using backend_dotnet8.Core.Dtos.Message;
using backend_dotnet8.Core.Entities;
using backend_dotnet8.Core.Interfaces;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace backend_dotnet8.Core.Services
{
    public class MessageService : IMessageService
    {
        private readonly ApplicationDbContext _context;
        private readonly ILogService _logService;
        private readonly UserManager<ApplicationUser> _userManager;

        public MessageService(ApplicationDbContext context, ILogService logService, UserManager<ApplicationUser> userManager)
        {
            _context = context;
            _logService = logService;
            _userManager = userManager;
        }

        public async Task<GeneralServiceResponseDto> CreateNewMessageAsync(ClaimsPrincipal User, CreateMessageDto createMessageDto)
        {
            if(User.Identity.Name == createMessageDto.ReceiverUserName)
            {
                return new GeneralServiceResponseDto { 
                    IsSuccess = false, 
                    Message = "You can't send message to yourself",
                    StatusCode = 400
                };
            }

            var isReceiverUserNameValid = _userManager.Users.Any(q=>q.UserName == createMessageDto.ReceiverUserName);
            if (!isReceiverUserNameValid)
            {
                return new GeneralServiceResponseDto
                {
                    IsSuccess = false,
                    Message = "Receiver UsernName is invalid",
                    StatusCode = 400
                };
            }
            var newMessage = new Message
            {
                SenderUserName = User.Identity.Name,
                ReceievrUserName = createMessageDto.ReceiverUserName,
                Text = createMessageDto.Text,
            };

            await _context.Messages.AddAsync(newMessage);
            await _context.SaveChangesAsync();
            await _logService.SaveNewLog(User.Identity.Name, $"User {User.Identity.Name} send a message to {createMessageDto.ReceiverUserName}");
            return new GeneralServiceResponseDto
            {
                IsSuccess = true,
                StatusCode = 201,
                Message = "Message saved successfully"
            };
        }

        public async Task<IEnumerable<GetMessageDto>> GetMessagesAsync()
        {
            var messages = await _context.Messages
                .Select(q => new GetMessageDto()
                {
                    Id = q.Id,
                    SenderUserName = q.SenderUserName,
                    ReceiverUserName = q.ReceievrUserName,
                    Text = q.Text,
                    CreatedAt = q.CreatedAt
                })
                .OrderByDescending(q => q.CreatedAt)
                .ToListAsync();
            return messages;
        }

        public async Task<IEnumerable<GetMessageDto>> GetMyMessagesAsync(ClaimsPrincipal User)
        {
            var loggerInUser = User.Identity.Name;
            var messages = await _context.Messages
                .Where(q=>q.SenderUserName == loggerInUser || q.ReceievrUserName == loggerInUser)
                .Select(q => new GetMessageDto()
                {
                    Id = q.Id,
                    SenderUserName = q.SenderUserName,
                    ReceiverUserName = q.ReceievrUserName,
                    Text = q.Text,
                    CreatedAt = q.CreatedAt
                })
                .OrderByDescending(q => q.CreatedAt)
                .ToListAsync();
            return messages;
        }
    }
}
