// ignore_for_file: non_constant_identifier_names

class Flashcard {
  int Id = 10;
  String Front = '';
  String Back = '';
  int FlashcardsSetId = 0;

  Flashcard(this.Id, this.Front, this.Back, this.FlashcardsSetId);

  Flashcard.fromJson(Map<String, dynamic> flashcardMap) {
    Id = flashcardMap['id'] ?? 0;
    Front = flashcardMap['front'] ?? '';
    Back = flashcardMap['back'] ?? '';
    FlashcardsSetId = flashcardMap['flashcardsSetId'] ?? 0;
  }

  Map<String, dynamic> toJson() => {
        'front': Front,
        'back': Back,
        'flashcardsSetId': FlashcardsSetId,
      };
}
