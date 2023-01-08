using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using LearnAppServerAPI.Data;
using LearnAppServerAPI.Data.Entities;
using CoreLearnAppServerAPI.Data;

namespace CoreLearnApp.Data
{
    public class LearnAppServerAPIRepository : ILearnAppServerAPIRepository
    {
        private readonly LearnAppServerAPIContext _context;
        private readonly ILogger<LearnAppServerAPIRepository> _logger;

        public LearnAppServerAPIRepository(LearnAppServerAPIContext context, ILogger<LearnAppServerAPIRepository> logger)
        {
            _context = context;
            _logger = logger;
        }

        public void Add<T>(T entity) where T : class
        {
            _logger.LogInformation($"Adding an object of type {entity.GetType()} to the context.");
            _context.Add(entity);
        }

        public void Delete<T>(T entity) where T : class
        {
            _logger.LogInformation($"Removing an object of type {entity.GetType()} to the context.");
            _context.Remove(entity);
        }

        public async Task<bool> SaveChangesAsync()
        {
            _logger.LogInformation($"Attempitng to save the changes in the context");

            // Only return success if at least one row was changed
            return (await _context.SaveChangesAsync()) > 0;
        }

        public async Task<User[]> GetAllUsersAsync()
        {
            var query = _context.Users;

            return await query.ToArrayAsync();
        }

        public async Task<User> GetUserByIdAsync(int id)
        {
            var query = _context.Users.Where(u => u.Id == id);

            return await query.FirstAsync();
        }

        public async Task<User> GetUserByEmailAndPasswordAsync(string email, string password)
        {
            var query = _context.Users.Where(u => u.Email == email && u.Password == password);
            return await query.FirstAsync();
        }

        public async Task<User> GetUserByEmailAsync(string email)
        {
            var query = _context.Users.Where(u => u.Email == email);
            return await query.FirstAsync();
        }
    }
}
