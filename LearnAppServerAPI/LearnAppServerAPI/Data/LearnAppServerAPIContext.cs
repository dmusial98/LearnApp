using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc.Diagnostics;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using LearnAppServerAPI.Data.Entities;
//using Microsoft.EntityFrameworkCore;
using System.Drawing;

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
        public DbSet<Flashcard> Flashcards { get; set; }
        public DbSet<FlashcardsSet> FlashcardsSets { get; set; }
        public DbSet<FlashcardLearnProperties> FlashcardLearnProperties { get; set; }

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
                    Email = "admin1@email.com",
                    Password = "E5E8B2D214DB8F3689BE77F6FDE9B64164B3E792EFB329E9A9B53993055D6C8E", // strongPassword1
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
                    Password = "6060E5564BE6B30CC9A6F961249E271FB8A6DDA9FE27C0B83AEB0E9129C51347", // strongPassword2
                    PhoneNumber = "+48987654321",
                    FacebookLink = "http:facebook.com/user/312",
                    TwitterLink = "http:twitter.com/user/312",
                    AboutMe = "I'm normal user"
                }
            );

            modelBuilder.Entity<Flashcard>().HasData(
                new
                {
                    Id = 1,
                    Front = "dog",
                    Back = "pies",
                    FlashcardsSetId = 1
                },
                new
                {
                    Id = 2,
                    Front = "cat",
                    Back = "kot",
                    FlashcardsSetId = 1
                },
                new
                {
                    Id = 3,
                    Front = "crocodile",
                    Back = "krokodyl",
                    FlashcardsSetId = 1
                },
                new
                {
                    Id = 4,
                    Front = "bird",
                    Back = "ptak",
                    FlashcardsSetId = 1
                },
                new
                {
                    Id = 5,
                    Front = "hamster",
                    Back = "chomik",
                    FlashcardsSetId = 1
                },
                new
                {
                    Id = 6,
                    Front = "table",
                    Back = "stół",
                    FlashcardsSetId = 2
                },
                new
                {
                    Id = 7,
                    Front = "bed",
                    Back = "łóżko",
                    FlashcardsSetId = 2
                },
                new
                {
                    Id = 8,
                    Front = "chair",
                    Back = "krzesło",
                    FlashcardsSetId = 2
                },
                new
                {
                    Id = 9,
                    Front = "desk",
                    Back = "biurko",
                    FlashcardsSetId = 2
                },
                new
                {
                    Id = 10,
                    Front = "wardrobe",
                    Back = "szafa",
                    FlashcardsSetId = 2
                },
                new
                {
                    Id = 11,
                    Front = "post office",
                    Back = "poczta",
                    FlashcardsSetId = 3
                },
                new
                {
                    Id = 12,
                    Front = "hospital",
                    Back = "szpital",
                    FlashcardsSetId = 3
                },
                new
                {
                    Id = 13,
                    Front = "jail",
                    Back = "więzienie",
                    FlashcardsSetId = 3
                },
                new
                {
                    Id = 14,
                    Front = "bridge",
                    Back = "most",
                    FlashcardsSetId = 3
                },
                new
                {
                    Id = 15,
                    Front = "house",
                    Back = "dom",
                    FlashcardsSetId = 3
                },
                new
                {
                    Id = 16,
                    Front = "tower",
                    Back = "wieża",
                    FlashcardsSetId = 3
                }
                );

            modelBuilder.Entity<FlashcardsSet>().HasData(
                new
                {
                    Id = 1,
                    EditorId = 1,
                    Name = "Animals",
                    Description = "Flashcards with animals.",
                    IsPublic = true,
                    Date = new DateTime(2023, 1, 1, 10, 28, 0),
                },
                new
                {
                    Id = 2,
                    EditorId = 2,
                    Name = "Furniture",
                    Description = "Flashcards with furniture.",
                    IsPublic = false,
                    Date = new DateTime(2023, 1, 2, 18, 2, 57),
                },
                new
                {
                    Id = 3,
                    EditorId = 1,
                    Name = "Buildings",
                    Description = "My flashcards set about buildings in English.",
                    IsPublic = true,
                    Date = new DateTime(2023, 2, 2, 18, 3, 57),
                }
                );

            modelBuilder.Entity<FlashcardLearnProperties>().HasData(
                new
                {
                    Id = 1,
                    FlashcardId = 1,
                    StudentId = 1,
                    IsFavourite = false,
                    ProgressFlashcard = 0,
                    ProgressABCDTest = 0,
                    ProgressTypeText = 0,
                }
                );
        }
    }
}
