using backend_dotnet8.Core.Constants;
using backend_dotnet8.Core.Dtos.Log;
using backend_dotnet8.Core.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace backend_dotnet8.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LogsController : Controller
    {
        private readonly ILogService _logService;

        public LogsController(ILogService logService)
        {
            _logService = logService;
        }

        [HttpGet]
        [Authorize(Roles = StaticUserRoles.OwnerAdmin)]
        public async Task<ActionResult<IEnumerable<GetLogDto>>> GetLogs()
        {
            var logs = await _logService.GetLogsAsync();
            return Ok(logs);
        }

        [HttpGet]
        [Route("mine")]
        //[Authorize] Significa que cualquiera que este registrado puede acceder
        [Authorize]
        public async Task<ActionResult<IEnumerable<GetLogDto>>> GetMyLogs()
        {
            var logs = await _logService.GetMyLogsAsync(User);
            return Ok(logs);
        }
    }

}
