using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace LearnAppServerAPI.Migrations
{
    /// <inheritdoc />
    public partial class NewFlashcardsSchema : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                column: "Email",
                value: "admin1@email.com");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                column: "Email",
                value: "admin1@emailcom");
        }
    }
}
