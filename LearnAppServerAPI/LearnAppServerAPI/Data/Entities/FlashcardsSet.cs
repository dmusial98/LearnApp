namespace LearnAppServerAPI.Data.Entities
{
    public class FlashcardsSet
    {
        public int Id { get; set; }
        public int Editor { get; set; }
        public int Name { get; set; }
        public string Description { get; set; }
        public DateTime Date { get; set; }
        public List<int> Flashcards { get; set; }
    }
}
