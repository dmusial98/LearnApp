namespace LearnAppServerAPI.Data.Entities
{
    public class User 
    {
        public int Id { get; set; }
        public bool IsAdmin { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public string PhoneNumber { get; set; }
        public string FacebookLink { get; set; }
        public string TwitterLink { get; set; }
        public string AboutMe { get; set; }
    }
}
