import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:my_app/data/http_helper.dart';
import 'package:my_app/shared/menu_bottom.dart';
import '../data/flashcard.dart';
import 'package:my_app/data/flashcards_set.dart';
import '../shared/menu_drawer.dart';

class FlashcardScreen extends StatefulWidget {
  FlashcardsSet flashcardsSet;

  FlashcardScreen({required Key? key, required this.flashcardsSet})
      : super(key: key);

  @override
  State<FlashcardScreen> createState() => _FlashcardState(flashcardsSet);
}

class _FlashcardState extends State<FlashcardScreen> {
  FlashcardsSet flashcardsSet = FlashcardsSet(0, 0, 'Name', 'Description',
      'Date', List<Flashcard>.filled(1, new Flashcard(0, 'front', 'back', 0)));
  int index = 0;
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  _FlashcardState(this.flashcardsSet);

  _renderBg() {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/sea.jpg'),
        fit: BoxFit.cover,
      )),
    );
  }

  _renderAppBar(context) {
    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      child: AppBar(
        elevation: 0.0,
        backgroundColor: Color.fromARGB(0, 12, 154, 214),
      ),
    );
  }

  _renderContent(BuildContext context) {
    return Container(
      child: Card(
        color: Colors.white70,
        elevation: 0.0,
        margin:
            EdgeInsets.only(left: 32.0, right: 32.0, top: 20.0, bottom: 0.0),
        child: FlipCard(
          key: cardKey,
          direction: FlipDirection.HORIZONTAL,
          speed: 0,
          onFlipDone: (status) {
            print(status);
          },
          front: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(flashcardsSet.Flashcards[index].Front,
                    style: Theme.of(context).textTheme.headline3),
                Text('Click here to flip back',
                    style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
          ),
          back: Container(
            decoration: BoxDecoration(
              // color: Color.fromARGB(255, 94, 223, 8),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(flashcardsSet.Flashcards[index].Back,
                    style: Theme.of(context).textTheme.headline3),
                Text('Click here to flip front',
                    style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(flashcardsSet.Name),
      ),
      bottomNavigationBar: MenuBottom(),
      drawer: MenuDrawer(),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _renderBg(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // _renderAppBar(context),
              Expanded(
                flex: 4,
                child: _renderContent(context),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    child: ElevatedButton(
                        onPressed: _correct, child: Text('Correct')),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    child:
                        ElevatedButton(onPressed: _wrong, child: Text('Wrong')),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  _correct() {
    //send message to server

    if (index + 1 < flashcardsSet.Flashcards.length)
      index++;
    else
      index = 0;

    if (cardKey.currentState?.isFront == false)
      cardKey.currentState?.toggleCard();

    setState(() {
      cardKey.currentState;
      index;
    });
  }

  _wrong() {
    //send message to server

    if (index + 1 < flashcardsSet.Flashcards.length)
      index++;
    else
      index = 0;

    if (cardKey.currentState?.isFront == false)
      cardKey.currentState?.toggleCard();

    setState(() {
      cardKey.currentState;
      index;
    });
  }
}
