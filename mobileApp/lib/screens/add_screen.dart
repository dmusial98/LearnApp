// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_app/shared/input_field_flashcard_widget.dart';
import 'package:my_app/shared/menu_bottom.dart';

import '../data/flashcard.dart';
import '../shared/menu_drawer.dart';

class AddScreen extends StatefulWidget {
  AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController flashcardTextFieldController =
      TextEditingController();
  List<Flashcard> flashcards =
      List<Flashcard>.filled(4, Flashcard(0, 'word', 'definition', 0));
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
    flashcardsListItems.add(Field());

    for (var element in flashcards) {
      flashcardsListItems.add(InputFieldFlashcardWidget(flashcard: element));
    }

    flashcardsListItems.add(AddButton('Add flashcard'));
    flashcardsListItems.add(SaveButton('Save flashcards set'));

    setState(() {
      flashcardsListItems = List.from(flashcardsListItems);
    });
  }
}

class Field extends StatelessWidget {
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
                  // controller: usersAnswer,
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

  SaveButton(this.text);

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
