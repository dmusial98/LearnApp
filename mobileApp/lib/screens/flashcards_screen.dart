import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:my_app/data/http_helper.dart';
import 'package:my_app/shared/menu_bottom.dart';
import '../data/flashcard.dart';
import 'package:my_app/data/flashcards_set.dart';
import '../data/flashcard_learn_properties.dart';
import '../data/global_data_singleton.dart';

class FlashcardScreen extends StatefulWidget {
  FlashcardsSet flashcardsSet;

  FlashcardScreen({required Key? key, required this.flashcardsSet})
      : super(key: key);

  @override
  State<FlashcardScreen> createState() => _FlashcardState(flashcardsSet);
}

class _FlashcardState extends State<FlashcardScreen> {
  FlashcardsSet flashcardsSet = FlashcardsSet(0, 0, 'Name', 'Description',
      List<Flashcard>.filled(1, new Flashcard(0, 'front', 'back', 0)));
  int index = 0;

  GlobalDataSingleton globalDataSingleton = GlobalDataSingleton();
  List<FlashcardLearnProperties> flashcardLearnPropertiesList =
      <FlashcardLearnProperties>[];

  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  bool isLastFlashcard = false;

  _FlashcardState(this.flashcardsSet);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadFlashcardLearnProperties();
    });
  }

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
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
            title: Text(flashcardsSet.Name),
          ),
          bottomNavigationBar: MenuBottom(),
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
                      GestureDetector(
                          onTap: () {
                            _buttonClicked(true);
                          },
                          child: _renderButton("Correct")),
                      GestureDetector(
                          onTap: () {
                            _buttonClicked(false);
                          },
                          child: _renderButton('Wrong'))
                    ],
                  )
                ],
              )
            ],
          ),
        ));
  }

  _renderBg() {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/sea.jpg'),
        fit: BoxFit.cover,
      )),
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

  _renderButton(String? text) {
    return Container(
      margin: const EdgeInsets.only(
          left: 32.0, right: 32.0, top: 20.0, bottom: 20.0),
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
  }

  Future<void> loadFlashcardSetData() async {
    HttpHelper httpHelper = HttpHelper();
    flashcardsSet =
        await httpHelper.getFlashcardsSetById(flashcardsSet.Id, true);
    setState(() {});
  }

  _buttonClicked(bool isCorrect) {
    int points = 0;

    if (isCorrect)
      points += 50;
    else
      points -= 50;

    FlashcardLearnProperties flashcardLearnProperties =
        flashcardLearnPropertiesList.firstWhere((element) =>
            element.FlashcardId == flashcardsSet.Flashcards[index].Id);

    flashcardLearnProperties.ProgressFlashcard += points;

    if (points > 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          content: Text(
              'Correct answer! Progress: ${flashcardLearnProperties.ProgressFlashcard}%')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          content: Text(
              'Wrong answer! Progress: ${flashcardLearnProperties.ProgressFlashcard > 0 ? flashcardLearnProperties.ProgressFlashcard : 0}%')));
    }

    if (flashcardsSet.Flashcards.length == 1 &&
        flashcardLearnProperties.ProgressFlashcard >= 100) {
      resetAllProgress();
      loadFlashcardSetData();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Congratulations! You have just mastered all flashcards! All stats reseted.')));
    }

    bool wasDeleted = false;

    if (flashcardLearnProperties.ProgressFlashcard >= 100 &&
        flashcardsSet.Flashcards.length > 1) {
      flashcardsSet.Flashcards.remove(flashcardsSet.Flashcards[index]);
      wasDeleted = true;
    } else if (flashcardLearnProperties.ProgressFlashcard < 0) {
      flashcardLearnProperties.ProgressFlashcard = 0;
    }

    if (wasDeleted && index + 1 > flashcardsSet.Flashcards.length)
      index = 0;
    else if (wasDeleted) {
      //do nothing
    } else if (index + 1 < flashcardsSet.Flashcards.length)
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

  void resetAllProgress() {
    for (var element in flashcardLearnPropertiesList) {
      element.ProgressFlashcard = 0;
    }
  }
}
