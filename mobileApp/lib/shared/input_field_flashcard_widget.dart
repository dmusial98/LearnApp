import 'package:flutter/material.dart';
import 'package:my_app/data/flashcard.dart';
import 'package:my_app/data/flashcards_set.dart';

class InputFieldFlashcardWidget extends StatelessWidget {
  Flashcard flashcard;
  InputFieldFlashcardWidget({Key? key, required this.flashcard})
      : super(key: key);

  TextEditingController frontController = TextEditingController();
  TextEditingController backController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
                left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
            width: 371,
            height: 70,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white70,
            ),
            padding: const EdgeInsets.all(20),
            child: Container(
              alignment: Alignment.centerLeft,
              child: TextField(
                  controller: frontController,
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(hintText: 'Type word')),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
                left: 5.0, right: 5.0, top: 5.0, bottom: 5.0),
            width: 371,
            height: 70,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white70,
            ),
            padding: const EdgeInsets.all(20),
            child: Container(
              alignment: Alignment.centerLeft,
              child: TextField(
                  controller: backController,
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(hintText: 'Type definition')),
            ),
          ),
        ],
      )
    ]);
  }
}
