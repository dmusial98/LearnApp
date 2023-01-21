using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace LearnAppServerAPI.Migrations
{
    /// <inheritdoc />
    public partial class FlashcardsWithProgressEntities : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
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
                        name: "FK_FlashcardLearnProperties_Flashcard_FlashcardId",
                        column: x => x.FlashcardId,
                        principalTable: "Flashcard",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_FlashcardLearnProperties_Users_StudentId",
                        column: x => x.StudentId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
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
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "FlashcardLearnProperties");
        }
    }
}
