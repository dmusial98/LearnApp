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
                      Column(
                        children: [
                          GestureDetector(
                              onTap: () {
                                goToFlashcards();
                              },
                              child: _renderButton("Flashcards")),
                          GestureDetector(
                              onTap: () {
                                goToTest();
                              },
                              child: _renderButton('Test')),
                          GestureDetector(
                              onTap: () {
                                goToTypeText();
                              },
                              child: _renderButton("Type test")),
                        ],
                      )
                    ],
                  )
                ],
              ),
            )));
  }

  _renderButton(String? text) {
    return Container(
      margin: const EdgeInsets.only(
          left: 32.0, right: 32.0, top: 10.0, bottom: 10.0),
      width: 100,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: Colors.white70,
        border: Border.all(width: 5, color: Colors.grey),
      ),
      child: Center(
          child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  style: const TextStyle(fontSize: 16, shadows: [
                    Shadow(
                        offset: Offset(2.0, 2.0),
                        blurRadius: 2.0,
                        color: Colors.grey)
                  ]),
                  children: <TextSpan>[
                    TextSpan(
                        text: text,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black)),
                  ]))),
    );
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

  void goToTypeText() {
    Navigator.pushNamed(context, '/flashcards_set_typetext',
        arguments: {'flashcardSetID': flashcardsSet.Id});
  }
}
