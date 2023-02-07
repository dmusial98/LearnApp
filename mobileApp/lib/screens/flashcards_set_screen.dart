import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:my_app/data/http_helper.dart';
import 'package:my_app/screens/flashcards_screen.dart';
import 'package:my_app/shared/menu_bottom.dart';
import '../data/flashcard.dart';
import 'package:my_app/data/flashcards_set.dart';
import '../shared/menu_drawer.dart';

class FlashcardsSetScreen extends StatefulWidget {
  const FlashcardsSetScreen({super.key});

  @override
  State<FlashcardsSetScreen> createState() => _FlashcardsSetState();
}

class _FlashcardsSetState extends State<FlashcardsSetScreen> {
  FlashcardsSet flashcardsSet = FlashcardsSet(0, 0, '', '', '', null);

  @override
  initState() {
    super.initState();
    _getFlashcardsSet();
  }

  Future<FlashcardsSet> _getFlashcardsSet() async {
    HttpHelper httpHelper = HttpHelper();
    try {
      FlashcardsSet tmpFlashcardsSet =
          await httpHelper.getFlashcardsSetById(2, true);
      setState(() {
        flashcardsSet = tmpFlashcardsSet;
      });
      return flashcardsSet;
    } catch (e) {
      FlashcardsSet tmpFlashcardsSet = FlashcardsSet(0, 0, 'name', '', '',
          List<Flashcard>.filled(1, new Flashcard(0, 'c', 'd', 0)));

      setState(() {
        flashcardsSet = tmpFlashcardsSet;
      });
      return tmpFlashcardsSet;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Flashcards set view')),
        bottomNavigationBar: MenuBottom(),
        drawer: MenuDrawer(),
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/sea.jpg'), fit: BoxFit.cover)),
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                        padding: const EdgeInsets.all(24),
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white70,
                        ),
                        child: Text(flashcardsSet.Name,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 22, shadows: [
                              Shadow(
                                  offset: Offset(1.0, 1.0),
                                  blurRadius: 2.0,
                                  color: Colors.grey)
                            ]))),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        child: ElevatedButton(
                            onPressed: _goToFlashcards,
                            child: Text('Flashcards')),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        child: ElevatedButton(
                            onPressed: _goToFlashcards,
                            child: Text('Text in mode')),
                      )
                    ],
                  )
                ],
              ),
            )));
  }

  Future _goToFlashcards() async {
    Navigator.pop(context);
    Navigator.pushNamed(context, '/flashcards',
        arguments: flashcardsSet.Flashcards);
  }
}
