using Microsoft.AspNetCore.Mvc;

namespace backend_dotnet8.Controllers
{
    public class LogsController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
