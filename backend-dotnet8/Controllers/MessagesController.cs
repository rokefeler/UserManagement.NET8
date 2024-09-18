using Microsoft.AspNetCore.Mvc;

namespace backend_dotnet8.Controllers
{
    public class MessagesController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
