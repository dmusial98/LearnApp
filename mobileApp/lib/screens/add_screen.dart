// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_app/data/flashcards_set.dart';
import 'package:my_app/shared/input_field_flashcard_widget.dart';
import 'package:my_app/shared/menu_bottom.dart';

import '../data/flashcard.dart';
import '../data/global_data_singleton.dart';
import '../data/http_helper.dart';
import '../shared/menu_drawer.dart';
import 'package:intl/intl.dart';

// class StaticPropertiesAddScreen {
//   static TextEditingController nameTextFieldController =
//       TextEditingController();
//   static TextEditingController descriptionFieldController =
//       TextEditingController();
// }

class AddScreen extends StatefulWidget {
  AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController nameTextFieldController = TextEditingController();
  TextEditingController descriptionTextFieldController =
      TextEditingController();
  static List<Flashcard> flashcards =
      List<Flashcard>.filled(1, Flashcard(0, 'word', 'definition', 0));
  List<TextEditingController> frontFlashcardsTextEditingControllers =
      List.empty(growable: true);
  List<TextEditingController> backFlashcardsTextEditingControllers =
      List.empty(growable: true);
  List<Widget> flashcardsListItems = <Widget>[];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setListWithWidgets();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Add')),
        bottomNavigationBar: MenuBottom(),
        drawer: MenuDrawer(),
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/sea.jpg'),
              fit: BoxFit.cover,
            )),
            child: ListView(
              children: flashcardsListItems,
            )));
  }

  setListWithWidgets() {
    flashcardsListItems
        .add(Field(nameTextFieldController, descriptionTextFieldController));

    for (var element in flashcards) {
      TextEditingController frontController = TextEditingController();
      TextEditingController backController = TextEditingController();
      frontFlashcardsTextEditingControllers.add(frontController);
      backFlashcardsTextEditingControllers.add(backController);
      flashcardsListItems.add(InputFieldFlashcardWidget(
        frontController: frontController,
        backController: backController,
      ));
    }

    flashcardsListItems.add(AddButton('Add flashcard'));
    flashcardsListItems
        .add(SaveButton('Save flashcards set', _saveFlashcardsSet));

    setState(() {
      flashcardsListItems = List.from(flashcardsListItems);
    });
  }

  _saveFlashcardsSet() async {
    HttpHelper httpHelper = HttpHelper();
    GlobalDataSingleton globalDataSingleton = GlobalDataSingleton();

    // List<Flashcard> _flashcards = <Flashcard>[];

    for (int i = 0; i < flashcardsListItems.length - 3; i++) {
      flashcards[i].Front = frontFlashcardsTextEditingControllers[i].text;
      flashcards[i].Back = backFlashcardsTextEditingControllers[i].text;
      // flashcards.add(Flashcard(0, frontFlashcardsTextEditingControllers[i].text,
      //     backFlashcardsTextEditingControllers[i].text, 0));
    }

    DateFormat dateFormat = DateFormat("dd.MM.yyyy HH:mm:ss");

    FlashcardsSet flashcardsSet = FlashcardsSet(
        0,
        globalDataSingleton.LoggedUserId,
        nameTextFieldController.text,
        descriptionTextFieldController.text,
        // dateFormat.format(DateTime.now()),
        flashcards);

    await httpHelper.createFlashcardsSet(flashcardsSet);
  }
}

class Field extends StatelessWidget {
  TextEditingController name;
  TextEditingController description;

  Field(this.name, this.description);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        Container(
          margin: const EdgeInsets.only(
              left: 10.0, right: 10.0, top: 10.0, bottom: 0.0),
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.black54,
          ),
          child: Container(
            margin: const EdgeInsets.only(
                left: 5.0, right: 5.0, top: 5.0, bottom: 0.0),
            width: 355,
            height: 80,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white70,
            ),
            padding: const EdgeInsets.all(20),
            child: Container(
              alignment: Alignment.centerLeft,
              child: TextField(
                  // onSubmitted: checkAnswer,
                  controller: name,
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(
                      hintText: 'Type name of flashcards set...')),
            ),
          ),
        )
      ]),
      Row(children: [
        Container(
          margin: const EdgeInsets.only(
              left: 10.0, right: 10.0, top: 5.0, bottom: 35.0),
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.black54,
          ),
          child: Container(
            margin: const EdgeInsets.only(
                left: 5.0, right: 5.0, top: 5.0, bottom: 0.0),
            width: 355,
            height: 90,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white70,
            ),
            padding: const EdgeInsets.all(20),
            child: Container(
              alignment: Alignment.centerLeft,
              child: TextField(
                  controller: description,
                  maxLines: 3,
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(hintText: 'Type description')),
            ),
          ),
        )
      ]),
    ]);
  }
}

class AddButton extends StatelessWidget {
  String text = '';

  AddButton(this.text);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Container(
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
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ]))),
        ));
  }
}

class SaveButton extends StatelessWidget {
  String text = '';
  VoidCallback callback;

  SaveButton(this.text, this.callback);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          callback();
        },
        child: Container(
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
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ]))),
        ));
  }

  // _saveFlashcardsSet() async {
  //   HttpHelper httpHelper = HttpHelper();
  //   GlobalDataSingleton globalDataSingleton = GlobalDataSingleton();

  //   // List<Flashcard> _flashcards = <Flashcard>

  //   for (int i = 0; i < flashcardsListItems.length - 2; i++) {}

  //   FlashcardsSet flashcardsSet = FlashcardsSet(
  //       0,
  //       globalDataSingleton.LoggedUserId,
  //       StaticPropertiesAddScreen.nameTextFieldController.text,
  //       StaticPropertiesAddScreen.descriptionFieldController.text,
  //       DateTime.now().toString(), <Flashcard>[]);

  //   await httpHelper.createFlashcardsSet(flashcardsSet);
  // }
}
