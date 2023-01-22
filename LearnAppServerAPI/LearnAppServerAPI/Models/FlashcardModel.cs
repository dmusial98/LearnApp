namespace LearnAppServerAPI.Models
{
    public class FlashcardModel
    {
        public int Id { get; set; }
        public string Front { get; set; }
        public string Back { get; set; }
        public int FlashcardsSetId { get; set; }
    }
}
