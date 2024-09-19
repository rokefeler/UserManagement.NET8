using backend_dotnet8.Core.Constants;
using backend_dotnet8.Core.Dtos.Message;
using backend_dotnet8.Core.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace backend_dotnet8.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MessagesController : Controller
    {
        private readonly IMessageService _messageService;

        public MessagesController(IMessageService messageService)
        {
            _messageService = messageService;
        }
        /// <summary>
        /// Create a new message to send to another user
        /// </summary>
        /// <param name="createMessageDto"></param>
        /// <returns></returns>
        [HttpPost]
        [Route("create")]
        [Authorize]
        public async Task<IActionResult> CreateNewMessage([FromBody] CreateMessageDto createMessageDto)
        {
            var result = await _messageService.CreateNewMessageAsync(User, createMessageDto);
            if (result.IsSuccess)
                return Ok(result.Message);

            return StatusCode(result.StatusCode, result.Message);
        }

        /// <summary>
        /// Get all messages for current user
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        [Route("mine")]
        [Authorize]
        public async Task<ActionResult<IEnumerable<GetMessageDto>>> GetMyMessages()
        {
            var messages = await _messageService.GetMyMessagesAsync(User);
            return Ok(messages);
        }

        /// <summary>
        /// Get all messages with Owner access and admin access
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        [Authorize(Roles = StaticUserRoles.OwnerAdmin)]
        public async Task<ActionResult<IEnumerable<GetMessageDto>>> GetMessages()
        {
            var messages = await _messageService.GetMessagesAsync();
            return Ok(messages);
        }
    }
}
