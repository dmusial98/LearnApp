using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc.Diagnostics;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using LearnAppServerAPI.Data.Entities;

namespace LearnAppServerAPI.Data
{
    public class LearnAppServerAPIContext : DbContext
    {
        private readonly IConfiguration _config;
        
        public LearnAppServerAPIContext(DbContextOptions options, IConfiguration config) : base(options)
        {
            _config = config;
        }

        public DbSet<User> Users { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlServer(_config.GetConnectionString("LearnApp"));
        }


        //dopisac pojedyncze encje
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<User>().HasData(
                new
                {
                    Id = 1,
                    IsAdmin = true,
                    Email = "admin1@emailcom",
                    Password = "strongPassword1",
                    PhoneNumber = "+48123456789",
                    FacebookLink = "http:facebook.com/user/123",
                    TwitterLink = "http:twitter.com/user/123",
                    AboutMe = "I'm admin"
                },
                new
                {
                    Id = 2,
                    IsAdmin = false,
                    Email = "user1@email.com",
                    Password = "strongPassword2",
                    PhoneNumber = "+48987654321",
                    FacebookLink = "http:facebook.com/user/312",
                    TwitterLink = "http:twitter.com/user/312",
                    AboutMe = "I'm normal user"

                });

           
           
        }
        

    }
}
