import 'package:flutter/material.dart';
import 'package:my_app/data/flashcards_set.dart';

class SetListItemWidget extends StatelessWidget {
  final FlashcardsSet flashcardSet;
  const SetListItemWidget({Key? key, required this.flashcardSet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, "/flashcards_set",
              arguments: {'flashcardSetID': flashcardSet.Id});
        },
        child: Container(
            padding: const EdgeInsets.all(24),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white70,
            ),
            height: 150,
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 2, color: Colors.black))),
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          style: const TextStyle(fontSize: 22, shadows: [
                            Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 2.0,
                                color: Colors.grey)
                          ]),
                          children: <TextSpan>[
                            TextSpan(
                                text: flashcardSet.Name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black))
                          ])),
                ),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: const TextStyle(fontSize: 22, shadows: [
                          Shadow(
                              offset: Offset(1.0, 1.0),
                              blurRadius: 2.0,
                              color: Colors.grey)
                        ]),
                        children: <TextSpan>[
                          TextSpan(
                              text: flashcardSet.Description,
                              style: const TextStyle(color: Colors.black))
                        ]))
              ],
            )));
  }
}
