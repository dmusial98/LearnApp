namespace LearnAppServerAPI.Data.Entities
{
    public class FlashcardLearnProperties
    {
        public int Id { get; set; }
        public Flashcard Flashcard { get; set; }
        public int FlashcardId { get; set; }
        public User Student { get; set; }
        public int StudentId { get; set; }
        public bool IsFavourite { get; set; }
        public int ProgressFlashcard { get; set; }
        public int ProgressABCDTest { get; set; }
        public int ProgressTypeText { get; set; }
    }
}
