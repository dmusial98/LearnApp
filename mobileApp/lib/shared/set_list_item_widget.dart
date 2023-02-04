import 'package:flutter/material.dart';

class SetListItemWidget extends StatelessWidget {
  final String title;
  final String description;
  const SetListItemWidget({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/flashcards_set",
            arguments: {'flashcardSetID': 123});
      },
      child: Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white70,
          ),
          child: Text("$title\n$description",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22, shadows: [
                Shadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 2.0,
                    color: Colors.grey)
              ]))),
    );
  }

  void GoToSetView() {}
}
