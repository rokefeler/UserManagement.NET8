﻿using System.ComponentModel.DataAnnotations;
using backend_dotnet8.Core.Enums;

namespace backend_dotnet8.Core.Dtos.Auth
{
    public class UpdateRoleDto
    {
        [Required(ErrorMessage = " UserName is required")]
        public string UserName { get; set; }
        public RoleType NewRole { get; set; }
    }
}
