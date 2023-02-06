// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_app/shared/menu_bottom.dart';

import '../data/flashcards_set.dart';
import '../data/http_helper.dart';
import '../shared/menu_drawer.dart';
import '../shared/test_item_widget.dart';

class FlashcardsSetTestScreen extends StatefulWidget {
  const FlashcardsSetTestScreen({super.key});

  @override
  State<FlashcardsSetTestScreen> createState() =>
      _FlashcardsSetTestScreenState();
}

class _FlashcardsSetTestScreenState extends State<FlashcardsSetTestScreen> {
  FlashcardsSet flashcardsSet = FlashcardsSet.empty();

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    flashcardsSet.Id = arguments['flashcardSetID'];

    return Scaffold(
        appBar: AppBar(title: Text(flashcardsSet.Name.toString())),
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/sea.jpg'),
              fit: BoxFit.cover,
            )),
            child: Center(
                child: Container(
                    margin: const EdgeInsets.only(
                        left: 32.0, right: 32.0, top: 20.0, bottom: 20.0),
                    padding: const EdgeInsets.all(24),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.black54,
                    ),
                    child: Column(
                      children: [
                        TestItem(text: 'Doggfdghsfgjdgsfghdsfgsfgdsgj'),
                        GestureDetector(
                            onTap: () {
                              checkAnswer(0);
                            },
                            child: TestItem(text: 'A. Pies')),
                        GestureDetector(
                            onTap: () {
                              checkAnswer(1);
                            },
                            child: TestItem(text: 'B. Kot')),
                        GestureDetector(
                            onTap: () {
                              checkAnswer(2);
                            },
                            child: TestItem(text: 'C. Chomik')),
                        GestureDetector(
                            onTap: () {
                              checkAnswer(3);
                            },
                            child: TestItem(text: 'D. Królik')),
                      ],
                    )))));
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadFlashcardSetData();
    });
  }

  void checkAnswer(int answerId) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Clicked answer: $answerId')));
  }

  void loadFlashcardSetData() async {
    HttpHelper httpHelper = HttpHelper();
    flashcardsSet =
        await httpHelper.getFlashcardsSetById(flashcardsSet.Id, false);
    setState(() {
      //email = txtEmail.text;
    });
  }

  void loadFlashcards() async {
    //...
  }
}
