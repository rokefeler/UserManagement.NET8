using backend_dotnet8.Core.Entities;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace backend_dotnet8.Core.DbContext
{
    /// <summary>
    /// Hereda de IdentityDbContext<ApplicationUser>, lo que significa que este contexto no solo manejará 
    /// las entidades de la aplicación, sino también las relacionadas con la gestión de usuarios y roles 
    /// gracias a ASP.NET Core Identity.
    /// </summary>
    public class ApplicationDbContext : IdentityDbContext<ApplicationUser>
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
        {
        }
        public DbSet<Log> Logs{ get; set; }
        public DbSet<Message> Messages { get; set; }
        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);

            //Config anything we want
            builder.Entity<ApplicationUser>(e =>
            {
                e.ToTable("Users", "Identity");
            });

            builder.Entity<IdentityUserClaim<string>>(e =>
            {
                e.ToTable("UserClaims", "Identity");
            });

            builder.Entity<IdentityUserLogin<string>>(e =>
            {
                e.ToTable("UserLogins", "Identity");
            });

            builder.Entity<IdentityUserToken<string>>(e =>
            {
                e.ToTable("UserTokens", "Identity");
            });

            builder.Entity<IdentityRole>(e =>
            {
                e.ToTable("Roles", "Identity");
            });

            builder.Entity<IdentityRoleClaim<string>>(e =>
            {
                e.ToTable("RoleClaims", "Identity");
            });

            builder.Entity<IdentityUserRole<string>>(e =>
            {
                e.ToTable("UserRoles", "Identity");
            });
        }
    }
}
