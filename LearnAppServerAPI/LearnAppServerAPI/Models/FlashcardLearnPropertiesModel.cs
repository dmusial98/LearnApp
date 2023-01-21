namespace LearnAppServerAPI.Models
{
    public class FlashcardLearnPropertiesModel
    {
        public int Id { get; set; }
        public FlashcardModel Flashcard { get; set; }
        public UserModel Student { get; set; }
        public bool IsFavourite { get; set; }
        public int ProgressFlashcard { get; set; }
        public int ProgressTypeText { get; set; }
    }
}
