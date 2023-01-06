using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.Extensions.Configuration;
using LearnAppServerAPI.Data;

namespace CoreLearnAppServerAPI.Data
{
    public class LearnAppServerAPIContextFactory : IDesignTimeDbContextFactory<LearnAppServerAPIContext>
    {
        public LearnAppServerAPIContext CreateDbContext(string[] args)
        {
            var config = new ConfigurationBuilder()
              .SetBasePath(Directory.GetCurrentDirectory())
              .AddJsonFile("appsettings.json")
              .Build();

            return new LearnAppServerAPIContext(new DbContextOptionsBuilder<LearnAppServerAPIContext>().Options, config);
        }
    }
}
