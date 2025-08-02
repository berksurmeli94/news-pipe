using Microsoft.AspNetCore.Mvc;

namespace backend.Controllers;

public class HomeController : BaseController<HomeController>
{
    [HttpGet]
    public IActionResult Get() => Ok(new { message = "Merhaba Vue!" });
}