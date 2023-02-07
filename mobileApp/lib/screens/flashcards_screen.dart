import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:my_app/data/http_helper.dart';

import '../data/flashcard.dart';
import 'package:my_app/data/flashcards_set.dart';

class FlashcardScreen extends StatefulWidget {
  List<Flashcard> flashcards =
      List<Flashcard>.filled(1, Flashcard(0, 'front', 'back', 0));

  FlashcardScreen({required Key? key, required this.flashcards})
      : super(key: key);

  @override
  State<FlashcardScreen> createState() => _FlashcardState(flashcards);
}

class _FlashcardState extends State<FlashcardScreen> {
  List<Flashcard> flashcards =
      new List<Flashcard>.filled(1, new Flashcard(0, 'front', 'back', 0));

  _FlashcardState(this.flashcards);

  _renderBg() {
    return Container(
      decoration: BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
    );
  }

  Future<FlashcardsSet> _getFlashcardsSet() async {
    HttpHelper httpHelper = HttpHelper();
    try {
      FlashcardsSet tmpFlashcard =
          await httpHelper.getFlashcardsSetById(1, true);
      return tmpFlashcard;
    } catch (e) {
      return FlashcardsSet(0, 0, '', '', '',
          new List<Flashcard>.filled(1, new Flashcard(0, 'c', 'd', 0)));
    }
  }

  _renderAppBar(context) {
    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      child: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0x00FFFFFF),
      ),
    );
  }

  _renderContent(BuildContext context) {
    return Card(
      elevation: 0.0,
      margin: EdgeInsets.only(left: 32.0, right: 32.0, top: 20.0, bottom: 0.0),
      color: Color(0x00000000),
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        speed: 1500,
        onFlipDone: (status) {
          print(status);
        },
        front: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 191, 208, 15),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(flashcards.first.Front,
                  style: Theme.of(context).textTheme.headline1),
              Text('Click here to flip back',
                  style: Theme.of(context).textTheme.bodyText1),
            ],
          ),
        ),
        back: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 94, 223, 8),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(flashcards.first.Back,
                  style: Theme.of(context).textTheme.headline1),
              Text('Click here to flip front',
                  style: Theme.of(context).textTheme.bodyText1),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlipCard'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _renderBg(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _renderAppBar(context),
              Expanded(
                flex: 4,
                child: _renderContent(context),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
