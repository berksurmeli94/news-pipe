using Microsoft.AspNetCore.Mvc;

namespace backend.Controllers;

[ApiController]
[Produces("application/json")]
[Route("api/[controller]")]
public class BaseController<T> : ControllerBase where T : BaseController<T> { }

