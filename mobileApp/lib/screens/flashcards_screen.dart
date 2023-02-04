import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:my_app/data/http_helper.dart';

import '../data/flashcard.dart';
import 'package:my_app/data/flashcards_set.dart';

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({super.key});

  @override
  State<FlashcardScreen> createState() => _FlashcardState();
}

class _FlashcardState extends State<FlashcardScreen> {
  _renderBg() {
    return Container(
      decoration:
          const BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
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
          List<Flashcard>.filled(1, Flashcard(0, 'c', 'd', 0)));
    }
  }

  _renderAppBar(context) {
    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      child: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0x00FFFFFF),
      ),
    );
  }

  _renderContent(BuildContext context) {
    return Card(
      elevation: 0.0,
      margin: const EdgeInsets.only(
          left: 32.0, right: 32.0, top: 20.0, bottom: 0.0),
      color: const Color(0x00000000),
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL,
        speed: 1500,
        onFlipDone: (status) {
          print(status);
        },
        front: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 191, 208, 15),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FutureBuilder<FlashcardsSet>(
                    future: _getFlashcardsSet(),
                    builder: (BuildContext _context,
                        AsyncSnapshot<FlashcardsSet> snapshot) {
                      List<Widget> children;
                      if (snapshot.hasData) {
                        children = <Widget>[
                          Text('${snapshot.data?.Flashcards.first.Front}')
                        ];
                      } else if (snapshot.hasError) {
                        children = <Widget>[
                          const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 60,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text('Error: ${snapshot.error}'),
                          ),
                        ];
                      } else {
                        children = const <Widget>[
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: CircularProgressIndicator(),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Text('Awaiting result...'),
                          ),
                        ];
                      }
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: children,
                        ),
                      );
                    })
              ]
              // children: <Widget>[
              //   Text('Front', style: Theme.of(context).textTheme.headline1),
              //   Text('Click here to flip back',
              //       style: Theme.of(context).textTheme.bodyText1),
              // ],
              ),
        ),
        back: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 94, 223, 8),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FutureBuilder<FlashcardsSet>(
                    future: _getFlashcardsSet(),
                    builder: (BuildContext _context,
                        AsyncSnapshot<FlashcardsSet> snapshot) {
                      List<Widget> children;
                      if (snapshot.hasData) {
                        children = <Widget>[
                          Text('${snapshot.data?.Flashcards[0].Back}')
                        ];
                      } else if (snapshot.hasError) {
                        children = <Widget>[
                          const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 60,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text('Error: ${snapshot.error}'),
                          ),
                        ];
                      } else {
                        children = const <Widget>[
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: CircularProgressIndicator(),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Text('Awaiting result...'),
                          ),
                        ];
                      }
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: children,
                        ),
                      );
                    })
              ]

              // children: <Widget>[
              //   Text('Back', style: Theme.of(context).textTheme.headline1),
              //   Text('Click here to flip front',
              //       style: Theme.of(context).textTheme.bodyText1),
              // ],
              ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlipCard'),
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
