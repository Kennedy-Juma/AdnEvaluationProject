using AdnEvaluationApi.Identity;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace AdnEvaluationApi.Data
{
    public class ApplicationDbContext : IdentityDbContext<ApplicationUser, ApplicationRole, int>
    {
            public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
            {
            }
        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);

                builder.Entity<ApplicationRole>(entity =>
                {
                    entity.ToTable("Roles");
                    entity.Property(r => r.ConcurrencyStamp).HasColumnType("longtext");
                });

                builder.Entity<ApplicationUser>(entity =>
                {
                    entity.ToTable("Users");
                    entity.Property(u => u.ConcurrencyStamp).HasColumnType("longtext");
                    entity.Property(u => u.SecurityStamp).HasColumnType("longtext");
                });

                builder.Entity<IdentityUserRole<int>>().ToTable("UserRoles");
                builder.Entity<IdentityUserClaim<int>>().ToTable("UserClaims");
                builder.Entity<IdentityUserLogin<int>>().ToTable("UserLogins");
                builder.Entity<IdentityRoleClaim<int>>().ToTable("RoleClaims");
                builder.Entity<IdentityUserToken<int>>().ToTable("UserTokens");
        }
        }
    }
    

