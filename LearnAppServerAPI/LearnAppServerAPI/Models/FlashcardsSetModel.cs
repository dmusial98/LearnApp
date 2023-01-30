namespace LearnAppServerAPI.Models
{
    public class FlashcardsSetModel
    {
        public int Id { get; set; }
        public UserModel Editor { get; set; }
        public int EditorId { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public bool IsPublic { get; set; }
        public DateTime Date { get; set; }
        public List<FlashcardModel> Flashcards { get; set; }
    }
}
