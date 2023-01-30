namespace LearnAppServerAPI.Data.Entities
{
    public class FlashcardsSet
    {
        public int Id { get; set; }
        public User Editor { get; set; }
        public int EditorId { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public bool IsPublic { get; set; }
        public DateTime Date { get; set; }
        public List<Flashcard> Flashcards { get; set; }
    }
}
