using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using LearnAppServerAPI.Data.Entities;

namespace CoreLearnAppServerAPI.Data
{
    public interface ILearnAppServerAPIRepository
    {
        // General 
        void Add<T>(T entity) where T : class;
        void Delete<T>(T entity) where T : class;
        Task<bool> SaveChangesAsync();

        // Users
        Task<User[]> GetAllUsersAsync();
        Task<User> GetUserByIdAsync(int id);
        Task<User> GetUserByEmailAndPasswordAsync(string login, string password);
        Task<User> GetUserByEmailAsync(string login);
    }
}