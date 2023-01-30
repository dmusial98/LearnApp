import '../data/flashcard.dart';

class FlashcardsSet {
  int Id = 0;
  int EditorId = 0;
  String Name = '';
  String Description = '';
  DateTime Date = new DateTime();
  List<Flashcard> Flashcards = [];

  FlashcardsSet(this.Id, this.EditorId, this.Name, this.Description, this.Date,
      this.Flashcards);

  FlashcardsSet.fromJson(Map<String, dynamic> flashcardsSetMap) {
    Id = flashcardsSetMap['id'] ?? 0;
    EditorId = flashcardsSetMap['editorId'] ?? 0;
    Name = flashcardsSetMap['name'] ?? '';
    Description = flashcardsSetMap['description'] ?? '';
    Date = flashcardsSetMap['date'] ?? new DateTime(1999);
  }

  Map<String, dynamic> toJson() => {
        'editorId': EditorId,
        'name': Name,
        'description': Description,
        'date': Date,
      };
}
