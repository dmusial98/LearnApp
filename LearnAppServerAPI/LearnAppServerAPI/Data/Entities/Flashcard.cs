﻿namespace LearnAppServerAPI.Data.Entities
{
    public class Flashcard
    {
        public int Id { get; set; }
        public string Front { get; set; }
        public string Back { get; set; }
        public int FlashcardsSetId { get; set; }
    }
}
