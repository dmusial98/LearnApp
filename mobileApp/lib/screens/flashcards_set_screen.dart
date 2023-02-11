// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_app/data/flashcards_set.dart';
import 'package:my_app/data/http_helper.dart';
import 'package:my_app/shared/menu_bottom.dart';

import '../shared/menu_drawer.dart';

class FlashcardSetScreen extends StatefulWidget {
  const FlashcardSetScreen({super.key});

  @override
  State<FlashcardSetScreen> createState() => _FlashcardSetScreenState();
}

class _FlashcardSetScreenState extends State<FlashcardSetScreen> {
  FlashcardsSet flashcardsSet = FlashcardsSet.empty();

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    flashcardsSet.Id = arguments['flashcardSetID'];

    return Scaffold(
        appBar: AppBar(title: Text(flashcardsSet.Name.toString())),
        //bottomNavigationBar: MenuBottom(),
        //drawer: MenuDrawer(),
        body: Center(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: ElevatedButton(
                  onPressed: goToFlashcards, child: Text('Flashcards')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: ElevatedButton(onPressed: goToTest, child: Text('Test')),
            ),
          ),
        ])));
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadFlashcardSetData();
    });
  }

  void loadFlashcardSetData() async {
    HttpHelper httpHelper = HttpHelper();
    flashcardsSet =
        await httpHelper.getFlashcardsSetById(flashcardsSet.Id, true);
    setState(() {
      // ...
    });
  }

  void goToFlashcards() {
    Navigator.pushNamed(context, '/flashcards', arguments: flashcardsSet);
  }

  void goToTest() {
    Navigator.pushNamed(context, '/flashcards_set_test',
        arguments: {'flashcardSetID': flashcardsSet.Id});
  }
}
