using backend_dotnet8.Core.DbContext;
using backend_dotnet8.Core.Dtos.Log;
using backend_dotnet8.Core.Entities;
using backend_dotnet8.Core.Interfaces;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace backend_dotnet8.Core.Services
{
    public class LogService : ILogService
    {
        private readonly ApplicationDbContext _context;

        public LogService(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<GetLogDto>> GetLogsAsync()
        {
            var logs = await _context.Logs
                .Select(q => new GetLogDto
                {
                    CreatedAt = q.CreatedAt,
                    Description = q.Description,
                    UserName = q.UserName
                }).OrderByDescending(q => q.CreatedAt)
                .ToListAsync();
            return logs;
        }

        public async Task<IEnumerable<GetLogDto>> GetMyLogsAsync(ClaimsPrincipal User)
        {
            var logs = await _context.Logs.Where(q=>q.UserName == User.Identity.Name)
                .Select(q => new GetLogDto
                {
                    CreatedAt = q.CreatedAt,
                    Description = q.Description,
                    UserName = q.UserName
                }).OrderByDescending(q => q.CreatedAt)
                .ToListAsync();
            return logs;
        }

        public async Task SaveNewLog(string userName, string description)
        {
            var newLog = new Log
            {
                UserName = userName,
                Description = description
            };
            
            await _context.Logs.AddAsync(newLog);
            await _context.SaveChangesAsync();
        }
    }
}
