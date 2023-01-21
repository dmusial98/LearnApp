﻿// <auto-generated />
using System;
using LearnAppServerAPI.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

#nullable disable

namespace LearnAppServerAPI.Migrations
{
    [DbContext(typeof(LearnAppServerAPIContext))]
    [Migration("20230121162911_FlashcardsWithProgressEntities")]
    partial class FlashcardsWithProgressEntities
    {
        /// <inheritdoc />
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "7.0.1")
                .HasAnnotation("Relational:MaxIdentifierLength", 128);

            SqlServerModelBuilderExtensions.UseIdentityColumns(modelBuilder);

            modelBuilder.Entity("LearnAppServerAPI.Data.Entities.Flashcard", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("Back")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<int?>("FlashcardsSetId")
                        .HasColumnType("int");

                    b.Property<string>("Front")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.HasIndex("FlashcardsSetId");

                    b.ToTable("Flashcard");

                    b.HasData(
                        new
                        {
                            Id = 1,
                            Back = "pies",
                            FlashcardsSetId = 1,
                            Front = "dog"
                        },
                        new
                        {
                            Id = 2,
                            Back = "kot",
                            FlashcardsSetId = 1,
                            Front = "cat"
                        },
                        new
                        {
                            Id = 3,
                            Back = "krokodyl",
                            FlashcardsSetId = 1,
                            Front = "crocodile"
                        },
                        new
                        {
                            Id = 4,
                            Back = "ptak",
                            FlashcardsSetId = 1,
                            Front = "bird"
                        },
                        new
                        {
                            Id = 5,
                            Back = "chomik",
                            FlashcardsSetId = 1,
                            Front = "hamster"
                        },
                        new
                        {
                            Id = 6,
                            Back = "stół",
                            FlashcardsSetId = 2,
                            Front = "table"
                        },
                        new
                        {
                            Id = 7,
                            Back = "łóżko",
                            FlashcardsSetId = 2,
                            Front = "bed"
                        },
                        new
                        {
                            Id = 8,
                            Back = "krzesło",
                            FlashcardsSetId = 2,
                            Front = "chair"
                        },
                        new
                        {
                            Id = 9,
                            Back = "biurko",
                            FlashcardsSetId = 2,
                            Front = "desk"
                        },
                        new
                        {
                            Id = 10,
                            Back = "szafa",
                            FlashcardsSetId = 2,
                            Front = "wardrobe"
                        });
                });

            modelBuilder.Entity("LearnAppServerAPI.Data.Entities.FlashcardLearnProperties", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<int>("FlashcardId")
                        .HasColumnType("int");

                    b.Property<bool>("IsFavourite")
                        .HasColumnType("bit");

                    b.Property<int>("ProgressFlashcard")
                        .HasColumnType("int");

                    b.Property<int>("ProgressTypeText")
                        .HasColumnType("int");

                    b.Property<int>("StudentId")
                        .HasColumnType("int");

                    b.HasKey("Id");

                    b.HasIndex("FlashcardId");

                    b.HasIndex("StudentId");

                    b.ToTable("FlashcardLearnProperties");

                    b.HasData(
                        new
                        {
                            Id = 1,
                            FlashcardId = 1,
                            IsFavourite = false,
                            ProgressFlashcard = 0,
                            ProgressTypeText = 0,
                            StudentId = 1
                        });
                });

            modelBuilder.Entity("LearnAppServerAPI.Data.Entities.FlashcardsSet", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<DateTime>("Date")
                        .HasColumnType("datetime2");

                    b.Property<string>("Description")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<int>("EditorId")
                        .HasColumnType("int");

                    b.Property<string>("Name")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.HasIndex("EditorId");

                    b.ToTable("FlashcardsSet");

                    b.HasData(
                        new
                        {
                            Id = 1,
                            Date = new DateTime(2023, 1, 1, 10, 28, 0, 0, DateTimeKind.Unspecified),
                            Description = "Flashcards with animals.",
                            EditorId = 1,
                            Name = "Animals"
                        },
                        new
                        {
                            Id = 2,
                            Date = new DateTime(2023, 1, 2, 18, 2, 57, 0, DateTimeKind.Unspecified),
                            Description = "Flashcards with furniture.",
                            EditorId = 2,
                            Name = "Furniture"
                        });
                });

            modelBuilder.Entity("LearnAppServerAPI.Data.Entities.User", b =>
                {
                    b.Property<int>("Id")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("Id"));

                    b.Property<string>("AboutMe")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Email")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("FacebookLink")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<bool>("IsAdmin")
                        .HasColumnType("bit");

                    b.Property<string>("Password")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("PhoneNumber")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("TwitterLink")
                        .IsRequired()
                        .HasColumnType("nvarchar(max)");

                    b.HasKey("Id");

                    b.ToTable("Users");

                    b.HasData(
                        new
                        {
                            Id = 1,
                            AboutMe = "I'm admin",
                            Email = "admin1@email.com",
                            FacebookLink = "http:facebook.com/user/123",
                            IsAdmin = true,
                            Password = "E5E8B2D214DB8F3689BE77F6FDE9B64164B3E792EFB329E9A9B53993055D6C8E",
                            PhoneNumber = "+48123456789",
                            TwitterLink = "http:twitter.com/user/123"
                        },
                        new
                        {
                            Id = 2,
                            AboutMe = "I'm normal user",
                            Email = "user1@email.com",
                            FacebookLink = "http:facebook.com/user/312",
                            IsAdmin = false,
                            Password = "6060E5564BE6B30CC9A6F961249E271FB8A6DDA9FE27C0B83AEB0E9129C51347",
                            PhoneNumber = "+48987654321",
                            TwitterLink = "http:twitter.com/user/312"
                        });
                });

            modelBuilder.Entity("LearnAppServerAPI.Data.Entities.Flashcard", b =>
                {
                    b.HasOne("LearnAppServerAPI.Data.Entities.FlashcardsSet", null)
                        .WithMany("Flashcards")
                        .HasForeignKey("FlashcardsSetId");
                });

            modelBuilder.Entity("LearnAppServerAPI.Data.Entities.FlashcardLearnProperties", b =>
                {
                    b.HasOne("LearnAppServerAPI.Data.Entities.Flashcard", "Flashcard")
                        .WithMany()
                        .HasForeignKey("FlashcardId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.HasOne("LearnAppServerAPI.Data.Entities.User", "Student")
                        .WithMany()
                        .HasForeignKey("StudentId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Flashcard");

                    b.Navigation("Student");
                });

            modelBuilder.Entity("LearnAppServerAPI.Data.Entities.FlashcardsSet", b =>
                {
                    b.HasOne("LearnAppServerAPI.Data.Entities.User", "Editor")
                        .WithMany()
                        .HasForeignKey("EditorId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Editor");
                });

            modelBuilder.Entity("LearnAppServerAPI.Data.Entities.FlashcardsSet", b =>
                {
                    b.Navigation("Flashcards");
                });
#pragma warning restore 612, 618
        }
    }
}
