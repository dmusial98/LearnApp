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
using static Microsoft.EntityFrameworkCore.DbLoggerCategory;

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

            return await query.FirstOrDefaultAsync();
        }

        public async Task<User> GetUserByEmailAndPasswordAsync(string email, string password)
        {
            var query = _context.Users.Where(u => u.Email == email && u.Password == password);
            return await query.FirstOrDefaultAsync();
        }

        public async Task<User> GetUserByEmailAsync(string email)
        {
            var query = _context.Users.Where(u => u.Email == email);
            return await query.FirstOrDefaultAsync();
        }

        public async Task<Flashcard[]> GetAllFlashcardsAsync()
        {
            var query = _context.Flashcards;

            return await query.ToArrayAsync(); 
        }

        public async Task<Flashcard> GetFlashcardByIdAsync(int id)
        {
            var query = _context.Flashcards.Where(f => f.Id == id);

            return await query.FirstOrDefaultAsync();
        }

        public async Task<Flashcard[]> GetFlashcardsByFlashcardSetIdAsync(int setId)
        {
            var query = _context.Flashcards.Where(f => f.FlashcardsSetId == setId);

            return await query.ToArrayAsync();
        }

        public async Task<FlashcardsSet[]> GetAllFlashcardsSetsAsync(bool withPrivateSets = false)
        {

            if (withPrivateSets)
            {
                var query = _context.FlashcardsSets;
                return await query.ToArrayAsync();
            }
            else
            {
                var query = _context.FlashcardsSets.Where(s => s.IsPublic);
                return await query.ToArrayAsync();
            }
        }

        public async Task<FlashcardsSet> GetFlashcardsSetByIdAsync(int setId, bool withFlashcards, bool withEditor)
        {
            var query = _context.FlashcardsSets.Where(s => s.Id == setId);
            
            if(withFlashcards)
                query = query.Include(s => s.Flashcards);

            if (withEditor)
                query = query.Include(s => s.Editor);

            return await query.FirstOrDefaultAsync();
        }

        public async Task<FlashcardsSet> GetFlashcardsSetByEditor(int id, bool withFlashcards, bool withEditor)
        {
            var query = _context.FlashcardsSets.Where(s => s.EditorId== id);

            if (withFlashcards)
                query = query.Include(s => s.Flashcards);

            if(withEditor)
                query.Include(s => s.Editor);

            return await query?.FirstOrDefaultAsync();
        }

        public async Task<FlashcardLearnProperties[]> GetAllFlashcardLearnPropertiesAsync()
        {
            var query = _context.FlashcardLearnProperties;

            return await query.ToArrayAsync();
        }

        public async Task<FlashcardLearnProperties> GetFlashcardLearnPropertiesByIdAsync(int id, bool withFlashcard, bool withStudent)
        {
            var query = _context.FlashcardLearnProperties.Where(f => f.Id == id);

            if (withFlashcard)
                query = query.Include(f => f.Flashcard);

            if(withStudent)
                query = query.Include(f => f.Student);

            return await query.FirstOrDefaultAsync();
        }

        public async Task<FlashcardLearnProperties> GetFlashcardLearnPropertiesByFlashcardIdAndStudentId(int FlashcardId, int StudentId, bool withFlashcard, bool withStudent)
        {
            var query = _context.FlashcardLearnProperties.Where(f => f.FlashcardId == FlashcardId && f.StudentId == StudentId);

            if (withFlashcard)
                query = query.Include(f => f.Flashcard);

            if (withStudent)
                query = query.Include(f => f.Student);

            return await query.FirstOrDefaultAsync();
        }
    }
}