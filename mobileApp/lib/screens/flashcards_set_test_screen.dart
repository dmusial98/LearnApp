// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:my_app/data/flashcard_learn_properties.dart';
import 'package:my_app/data/global_data_singleton.dart';
import 'package:my_app/shared/menu_bottom.dart';

import '../data/flashcard.dart';
import '../data/flashcards_set.dart';
import '../data/http_helper.dart';
import '../data/random_helper.dart';
import '../shared/menu_drawer.dart';
import '../shared/question_item_widget.dart';
import '../shared/test_item_widget.dart';

class FlashcardsSetTestScreen extends StatefulWidget {
  const FlashcardsSetTestScreen({super.key});

  @override
  State<FlashcardsSetTestScreen> createState() =>
      _FlashcardsSetTestScreenState();
}

class _FlashcardsSetTestScreenState extends State<FlashcardsSetTestScreen> {
  FlashcardsSet flashcardsSet = FlashcardsSet.empty();
  GlobalDataSingleton globalDataSingleton = GlobalDataSingleton();
  List<Flashcard> testFlashcards = <Flashcard>[];
  List<FlashcardLearnProperties> flashcardLearnPropertiesList =
      <FlashcardLearnProperties>[];
  String question = '';
  List<String> answers = ['', '', '', ''];
  int correctAnswerIndex = 0;

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Progress?'),
            content: Text('Do you want to save the progress?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('No'),
              ),
              TextButton(
                onPressed: saveProgress,
                child: Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  void saveProgress() async {
    HttpHelper httpHelper = HttpHelper();
    for (var element in flashcardLearnPropertiesList) {
      try {
        await httpHelper.updateFlashcardsLearnProperties(element);
      } catch (e) {
        try {
          await httpHelper.createFlashcardsLearnProperties(element);
        } catch (e) {
          // ...
        }
      }
    }
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    flashcardsSet.Id = arguments['flashcardSetID'];

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
                          QuestionTestItem(text: question),
                          GestureDetector(
                              onTap: () {
                                checkAnswer(0);
                              },
                              child: TestItem(text: 'A. ${answers[0]}')),
                          GestureDetector(
                              onTap: () {
                                checkAnswer(1);
                              },
                              child: TestItem(text: 'B. ${answers[1]}')),
                          GestureDetector(
                              onTap: () {
                                checkAnswer(2);
                              },
                              child: TestItem(text: 'C. ${answers[2]}')),
                          GestureDetector(
                              onTap: () {
                                checkAnswer(3);
                              },
                              child: TestItem(text: 'D. ${answers[3]}')),
                        ],
                      ))))),
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      initTest();
    });
  }

  void initTest() async {
    await loadFlashcardSetData();
    await loadFlashcardLearnProperties();
    matchTrainingFlashcards();
    loadQuestion();
  }

  void checkAnswer(int answerId) {
    int points = 0;
    if (correctAnswerIndex == answerId) {
      points = 20;
    } else {
      points = -20;
    }
    FlashcardLearnProperties flashcardLearnProperties =
        flashcardLearnPropertiesList.firstWhere(
            (element) => element.FlashcardId == testFlashcards[0].Id);

    flashcardLearnProperties.ProgressABCDTest += points;

    if (flashcardLearnProperties.ProgressABCDTest >= 100) {
      testFlashcards.remove(testFlashcards[0]);
    } else if (flashcardLearnProperties.ProgressABCDTest < 0) {
      flashcardLearnProperties.ProgressABCDTest = 0;
    }

    if (points > 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          content: Text(
              'Correct answer! Progress: ${flashcardLearnProperties.ProgressABCDTest}%')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          content: Text(
              'Wrong answer! Progress: ${flashcardLearnProperties.ProgressABCDTest}%')));
    }

    if (testFlashcards.isNotEmpty) {
      shuffleTestFlashcards();
      testFlashcards.add(testFlashcards[0]);
      testFlashcards.removeAt(0);
    } else {
      resetAllABCDProgress();
      matchTrainingFlashcards();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Congratulations! You have just mastered all flashcards! All stats reseted.')));
    }

    loadQuestion();
  }

  void shuffleTestFlashcards() {
    //testFlashcards.shuffle();
    shuffle(testFlashcards, 1, testFlashcards.length);
  }

  void resetAllABCDProgress() {
    for (var element in flashcardLearnPropertiesList) {
      element.ProgressABCDTest = 0;
    }
  }

  void loadQuestion() {
    if (testFlashcards.isEmpty) {
      for (var element in flashcardLearnPropertiesList) {
        element.ProgressABCDTest = 0;
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('ABCD ratings reseted!')));
    } else {
      question = testFlashcards[0].Back;
      loadAnswers();
    }
    setState(() {
      // ...
    });
  }

  void loadAnswers() {
    String correctAnswer = testFlashcards[0].Front;
    var rng = Random();

    correctAnswerIndex = rng.nextInt(4);
    answers[correctAnswerIndex] = correctAnswer;
    int orgID = flashcardsSet.Flashcards.indexOf(testFlashcards[0]);
    List<int> randomNumbers = RandomHelper
        .generateRandomIntsFromRangeWithoutRepetitionAndWithoutNumber(
            flashcardsSet.Flashcards.length, 4, orgID);
    for (int i = 0; i < 4; i++) {
      if (i != correctAnswerIndex) {
        answers[i] = flashcardsSet.Flashcards[randomNumbers[i]].Front;
      }
    }
  }

  void matchTrainingFlashcards() {
    for (var currentFlashcard in flashcardsSet.Flashcards) {
      if (flashcardLearnPropertiesList
              .firstWhere(
                  (element) => element.FlashcardId == currentFlashcard.Id)
              .ProgressABCDTest !=
          100) {
        testFlashcards.add(currentFlashcard);
      }
    }

    setState(() {
      // ...
    });
  }

  Future<void> loadFlashcardSetData() async {
    HttpHelper httpHelper = HttpHelper();
    flashcardsSet =
        await httpHelper.getFlashcardsSetById(flashcardsSet.Id, true);
    setState(() {
      //email = txtEmail.text;
    });
  }

  Future<void> loadFlashcardLearnProperties() async {
    HttpHelper httpHelper = HttpHelper();
    for (var element in flashcardsSet.Flashcards) {
      try {
        flashcardLearnPropertiesList.add(await httpHelper
            .getFlashcardsLearnPropertyByFlashcardIdAndStudentId(
                element.Id, globalDataSingleton.LoggedUserId));
      } catch (e) {
        flashcardLearnPropertiesList.add(FlashcardLearnProperties(
            0, element.Id, globalDataSingleton.LoggedUserId, false, 0, 0, 0));
      }
    }

    setState(() {
      //email = txtEmail.text;
    });
  }
}
