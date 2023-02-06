using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace LearnAppServerAPI.Migrations
{
    /// <inheritdoc />
    public partial class ABCDprogressadded : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "ProgressABCDTest",
                table: "FlashcardLearnProperties",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.UpdateData(
                table: "FlashcardLearnProperties",
                keyColumn: "Id",
                keyValue: 1,
                column: "ProgressABCDTest",
                value: 0);

            migrationBuilder.InsertData(
                table: "FlashcardsSets",
                columns: new[] { "Id", "Date", "Description", "EditorId", "IsPublic", "Name" },
                values: new object[] { 3, new DateTime(2023, 2, 2, 18, 3, 57, 0, DateTimeKind.Unspecified), "My flashcards set about buildings in English.", 1, true, "Buildings" });

            migrationBuilder.InsertData(
                table: "Flashcards",
                columns: new[] { "Id", "Back", "FlashcardsSetId", "Front" },
                values: new object[,]
                {
                    { 11, "poczta", 3, "post office" },
                    { 12, "szpital", 3, "hospital" },
                    { 13, "więzienie", 3, "jail" },
                    { 14, "most", 3, "bridge" },
                    { 15, "dom", 3, "house" },
                    { 16, "wieża", 3, "tower" }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Flashcards",
                keyColumn: "Id",
                keyValue: 11);

            migrationBuilder.DeleteData(
                table: "Flashcards",
                keyColumn: "Id",
                keyValue: 12);

            migrationBuilder.DeleteData(
                table: "Flashcards",
                keyColumn: "Id",
                keyValue: 13);

            migrationBuilder.DeleteData(
                table: "Flashcards",
                keyColumn: "Id",
                keyValue: 14);

            migrationBuilder.DeleteData(
                table: "Flashcards",
                keyColumn: "Id",
                keyValue: 15);

            migrationBuilder.DeleteData(
                table: "Flashcards",
                keyColumn: "Id",
                keyValue: 16);

            migrationBuilder.DeleteData(
                table: "FlashcardsSets",
                keyColumn: "Id",
                keyValue: 3);

            migrationBuilder.DropColumn(
                name: "ProgressABCDTest",
                table: "FlashcardLearnProperties");
        }
    }
}
