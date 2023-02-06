import '../data/flashcard.dart';

class FlashcardsSet {
  int Id = 0;
  int EditorId = 0;
  String Name = '';
  String Description = '';
  String Date = '';
  List<Flashcard> Flashcards = [];

  FlashcardsSet.empty();

  FlashcardsSet(this.Id, this.EditorId, this.Name, this.Description, this.Date,
      this.Flashcards);

  FlashcardsSet.fromJson(Map<String, dynamic> flashcardsSetMap) {
    Id = flashcardsSetMap['id'] ?? 0;
    EditorId = flashcardsSetMap['editorId'] ?? 0;
    Name = flashcardsSetMap['name'] ?? '';
    Description = flashcardsSetMap['description'] ?? '';
    Date = flashcardsSetMap['date'] ?? '';
    Flashcards = (flashcardsSetMap['flashcards'] as List).map((i) {
      return Flashcard.fromJson(i);
    }).toList();
  }

  Map<String, dynamic> toJson() => {
        'editorId': EditorId,
        'name': Name,
        'description': Description,
        'date': Date,
      };
}
