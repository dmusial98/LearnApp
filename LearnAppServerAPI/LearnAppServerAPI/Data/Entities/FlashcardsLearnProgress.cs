namespace LearnAppServerAPI.Data.Entities
{
    public class FlashcardsLearnProgress
    {
        public int Id { get; set; }
        public FlashcardsSet Set { get; set; }
        public User Student { get; set; }

    }
}
