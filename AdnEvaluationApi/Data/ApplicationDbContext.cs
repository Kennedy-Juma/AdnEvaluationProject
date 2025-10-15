using AdnEvaluationApi.Identity;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace AdnEvaluationApi.Data
{
    public class ApplicationDbContext : IdentityDbContext<ApplicationUser>
      {
            public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
            {
            }
        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);

                builder.Entity<IdentityRole>(entity =>
                {
                    entity.Property(r => r.ConcurrencyStamp).HasColumnType("longtext");
                });

                builder.Entity<IdentityUser>(entity =>
                {
                    entity.Property(u => u.ConcurrencyStamp).HasColumnType("longtext");
                    entity.Property(u => u.SecurityStamp).HasColumnType("longtext");
                });
            }
        }
    }
    

