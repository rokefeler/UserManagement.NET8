using Microsoft.AspNetCore.Identity;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations.Schema;

namespace backend_dotnet8.Core.Entities
{
    public class ApplicationUser : IdentityUser
    {
        public required string FirstName { get; set; } /*readonly, init, const, abstract, virtual, override, sealed, protected, private set*/
        public string LastName { get; set; }
        public string Address { get; set; }
        public DateTime CreatedAt { get; set; } = DateTime.Now;
        [NotMapped]
        public IList<string> Roles { get; set; }
    }
}
