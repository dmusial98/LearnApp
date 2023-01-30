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

        //Flashcards
        Task<Flashcard[]> GetAllFlashcardsAsync();
        Task<Flashcard> GetFlashcardByIdAsync(int id);
        Task<Flashcard[]> GetFlashcardsByFlashcardSetIdAsync(int setId);

        //FlashcardsSet
        Task<FlashcardsSet[]> GetAllFlashcardsSetsAsync(bool withPrivateSets = false);
        Task<FlashcardsSet> GetFlashcardsSetByIdAsync(int setId, bool withFlashcards, bool withEditor);
        Task<FlashcardsSet> GetFlashcardsSetByEditor(int id, bool withFlashcards, bool withEditor);


        //FlashcardLearnProperties
        Task<FlashcardLearnProperties[]> GetAllFlashcardLearnPropertiesAsync();
        Task<FlashcardLearnProperties> GetFlashcardLearnPropertiesByIdAsync(int id, bool withFlashcard, bool withStudent);
        Task<FlashcardLearnProperties> GetFlashcardLearnPropertiesByFlashcardIdAndStudentId(int FlashcardId, int StudentId, bool withFlashcard, bool withStudent);
    }
}