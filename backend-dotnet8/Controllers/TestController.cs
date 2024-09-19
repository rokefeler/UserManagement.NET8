﻿using backend_dotnet8.Core.Constants;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace backend_dotnet8.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TestController : Controller
    {
        [HttpGet]
        [Route("get-public")]
        public IActionResult GetPublicData()
        {
            return Ok("Public data");
        }

        [HttpGet]
        [Route("get-user-role")]
        [Authorize(Roles = StaticUserRoles.USER)]
        public IActionResult GetUserData()
        {
            return Ok("User Role Data");
        }

        [HttpGet]
        [Route("get-manager-role")]
        [Authorize(Roles = StaticUserRoles.MANAGER)]
        public IActionResult GetManagerData()
        {
            return Ok("Manager Role Data");
        }


        [HttpGet]
        [Route("get-admin-role")]
        [Authorize(Roles = StaticUserRoles.ADMIN)]
        public IActionResult GetAdminData()
        {
            return Ok("Admin Role Data");
        }

        [HttpGet]
        [Route("get-owner-role")]
        [Authorize(Roles = StaticUserRoles.OWNER)]
        public IActionResult GetOwnerData()
        {
            return Ok("Owner Role Data");
        }
    }


}
