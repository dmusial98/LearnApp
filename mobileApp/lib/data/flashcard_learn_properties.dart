// ignore_for_file: non_constant_identifier_names

class FlashcardLearnProperties {
  int Id = 0;
  int FlashcardId = 0;
  int StudentId = 0;
  bool IsFavourite = false;
  int ProgressFlashcard = 0;
  int ProgressABCDTest = 0;
  int ProgressTypeText = 0;

  FlashcardLearnProperties(
      this.Id,
      this.FlashcardId,
      this.StudentId,
      this.IsFavourite,
      this.ProgressFlashcard,
      this.ProgressABCDTest,
      this.ProgressTypeText);

  FlashcardLearnProperties.fromJson(Map<String, dynamic> flashcardMap) {
    Id = flashcardMap['id'] ?? 0;
    FlashcardId = flashcardMap['flashcardId'] ?? 0;
    StudentId = flashcardMap['studentId'] ?? 0;
    IsFavourite = flashcardMap['isFavourite'] ?? false;
    ProgressFlashcard = flashcardMap['progressFlashcard'] ?? 0;
    ProgressABCDTest = flashcardMap['progressABCDTest'] ?? 0;
    ProgressTypeText = flashcardMap['progressTypeText'] ?? 0;
  }

  Map<String, dynamic> toJson() => {
        'flashcardId': FlashcardId,
        'studentId': StudentId,
        'isFavourite': IsFavourite,
        'progressFlashcard': ProgressFlashcard,
        'progressABCDTest': ProgressABCDTest,
        'progressTypeText': ProgressTypeText,
      };
}
