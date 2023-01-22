using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace LearnAppServerAPI.Migrations
{
    /// <inheritdoc />
    public partial class Init : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Users",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    IsAdmin = table.Column<bool>(type: "bit", nullable: false),
                    Email = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Password = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    PhoneNumber = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    FacebookLink = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    TwitterLink = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    AboutMe = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Users", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "FlashcardsSets",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    EditorId = table.Column<int>(type: "int", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Description = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Date = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_FlashcardsSets", x => x.Id);
                    table.ForeignKey(
                        name: "FK_FlashcardsSets_Users_EditorId",
                        column: x => x.EditorId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.NoAction);
                });

            migrationBuilder.CreateTable(
                name: "Flashcards",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Front = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Back = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    FlashcardsSetId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Flashcards", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Flashcards_FlashcardsSets_FlashcardsSetId",
                        column: x => x.FlashcardsSetId,
                        principalTable: "FlashcardsSets",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.NoAction);
                });

            migrationBuilder.CreateTable(
                name: "FlashcardLearnProperties",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    FlashcardId = table.Column<int>(type: "int", nullable: false),
                    StudentId = table.Column<int>(type: "int", nullable: false),
                    IsFavourite = table.Column<bool>(type: "bit", nullable: false),
                    ProgressFlashcard = table.Column<int>(type: "int", nullable: false),
                    ProgressTypeText = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_FlashcardLearnProperties", x => x.Id);
                    table.ForeignKey(
                        name: "FK_FlashcardLearnProperties_Flashcards_FlashcardId",
                        column: x => x.FlashcardId,
                        principalTable: "Flashcards",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.NoAction);
                    table.ForeignKey(
                        name: "FK_FlashcardLearnProperties_Users_StudentId",
                        column: x => x.StudentId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.NoAction);
                });

            migrationBuilder.InsertData(
                table: "Users",
                columns: new[] { "Id", "AboutMe", "Email", "FacebookLink", "IsAdmin", "Password", "PhoneNumber", "TwitterLink" },
                values: new object[,]
                {
                    { 1, "I'm admin", "admin1@email.com", "http:facebook.com/user/123", true, "E5E8B2D214DB8F3689BE77F6FDE9B64164B3E792EFB329E9A9B53993055D6C8E", "+48123456789", "http:twitter.com/user/123" },
                    { 2, "I'm normal user", "user1@email.com", "http:facebook.com/user/312", false, "6060E5564BE6B30CC9A6F961249E271FB8A6DDA9FE27C0B83AEB0E9129C51347", "+48987654321", "http:twitter.com/user/312" }
                });

            migrationBuilder.InsertData(
                table: "FlashcardsSets",
                columns: new[] { "Id", "Date", "Description", "EditorId", "Name" },
                values: new object[,]
                {
                    { 1, new DateTime(2023, 1, 1, 10, 28, 0, 0, DateTimeKind.Unspecified), "Flashcards with animals.", 1, "Animals" },
                    { 2, new DateTime(2023, 1, 2, 18, 2, 57, 0, DateTimeKind.Unspecified), "Flashcards with furniture.", 2, "Furniture" }
                });

            migrationBuilder.InsertData(
                table: "Flashcards",
                columns: new[] { "Id", "Back", "FlashcardsSetId", "Front" },
                values: new object[,]
                {
                    { 1, "pies", 1, "dog" },
                    { 2, "kot", 1, "cat" },
                    { 3, "krokodyl", 1, "crocodile" },
                    { 4, "ptak", 1, "bird" },
                    { 5, "chomik", 1, "hamster" },
                    { 6, "stół", 2, "table" },
                    { 7, "łóżko", 2, "bed" },
                    { 8, "krzesło", 2, "chair" },
                    { 9, "biurko", 2, "desk" },
                    { 10, "szafa", 2, "wardrobe" }
                });

            migrationBuilder.InsertData(
                table: "FlashcardLearnProperties",
                columns: new[] { "Id", "FlashcardId", "IsFavourite", "ProgressFlashcard", "ProgressTypeText", "StudentId" },
                values: new object[] { 1, 1, false, 0, 0, 1 });

            migrationBuilder.CreateIndex(
                name: "IX_FlashcardLearnProperties_FlashcardId",
                table: "FlashcardLearnProperties",
                column: "FlashcardId");

            migrationBuilder.CreateIndex(
                name: "IX_FlashcardLearnProperties_StudentId",
                table: "FlashcardLearnProperties",
                column: "StudentId");

            migrationBuilder.CreateIndex(
                name: "IX_Flashcards_FlashcardsSetId",
                table: "Flashcards",
                column: "FlashcardsSetId");

            migrationBuilder.CreateIndex(
                name: "IX_FlashcardsSets_EditorId",
                table: "FlashcardsSets",
                column: "EditorId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "FlashcardLearnProperties");

            migrationBuilder.DropTable(
                name: "Flashcards");

            migrationBuilder.DropTable(
                name: "FlashcardsSets");

            migrationBuilder.DropTable(
                name: "Users");
        }
    }
}
