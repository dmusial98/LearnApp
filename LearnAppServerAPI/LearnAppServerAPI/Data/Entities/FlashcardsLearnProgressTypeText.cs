namespace LearnAppServerAPI.Data.Entities
{
    public class FlashcardsLearnProgressTypeText
    {
        public int Id { get; set; }
        public FlashcardsSet Flashcards {get; set;}
        public User Student { get; set; }
    }
}
