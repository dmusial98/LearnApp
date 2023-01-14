using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace LearnAppServerAPI.Migrations
{
    /// <inheritdoc />
    public partial class newPassword : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                column: "Password",
                value: "E5E8B2D214DB8F3689BE77F6FDE9B64164B3E792EFB329E9A9B53993055D6C8E");

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 2,
                column: "Password",
                value: "6060E5564BE6B30CC9A6F961249E271FB8A6DDA9FE27C0B83AEB0E9129C51347");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 1,
                column: "Password",
                value: "strongPassword1");

            migrationBuilder.UpdateData(
                table: "Users",
                keyColumn: "Id",
                keyValue: 2,
                column: "Password",
                value: "strongPassword2");
        }
    }
}
