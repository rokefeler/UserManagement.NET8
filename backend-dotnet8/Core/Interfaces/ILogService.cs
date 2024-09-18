using backend_dotnet8.Core.Dtos.Log;
using System.Security.Claims;

namespace backend_dotnet8.Core.Interfaces
{
    public interface ILogService
    {
        Task SaveNewLog(string userName,string description);
        Task<IEnumerable<GetLogDto>> GetLogsAsync();
        Task<IEnumerable<GetLogDto>> GetMyLogsAsync(ClaimsPrincipal User);
    }
}
