using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace LearnAppServerAPI.Migrations
{
    /// <inheritdoc />
    public partial class FlashcardsWithProgress : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "FlashcardsSet",
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
                    table.PrimaryKey("PK_FlashcardsSet", x => x.Id);
                    table.ForeignKey(
                        name: "FK_FlashcardsSet_Users_EditorId",
                        column: x => x.EditorId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "Flashcard",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Front = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Back = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    FlashcardsSetId = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Flashcard", x => x.Id);
                    table.ForeignKey(
                        name: "FK_Flashcard_FlashcardsSet_FlashcardsSetId",
                        column: x => x.FlashcardsSetId,
                        principalTable: "FlashcardsSet",
                        principalColumn: "Id");
                });

            migrationBuilder.InsertData(
                table: "FlashcardsSet",
                columns: new[] { "Id", "Date", "Description", "EditorId", "Name" },
                values: new object[,]
                {
                    { 1, new DateTime(2023, 1, 1, 10, 28, 0, 0, DateTimeKind.Unspecified), "Flashcards with animals.", 1, "Animals" },
                    { 2, new DateTime(2023, 1, 2, 18, 2, 57, 0, DateTimeKind.Unspecified), "Flashcards with furniture.", 2, "Furniture" }
                });

            migrationBuilder.InsertData(
                table: "Flashcard",
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

            migrationBuilder.CreateIndex(
                name: "IX_Flashcard_FlashcardsSetId",
                table: "Flashcard",
                column: "FlashcardsSetId");

            migrationBuilder.CreateIndex(
                name: "IX_FlashcardsSet_EditorId",
                table: "FlashcardsSet",
                column: "EditorId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Flashcard");

            migrationBuilder.DropTable(
                name: "FlashcardsSet");
        }
    }
}
