// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_app/shared/menu_bottom.dart';

import '../data/flashcard.dart';
import '../data/flashcards_set.dart';
import '../data/http_helper.dart';
import '../shared/menu_drawer.dart';
import '../shared/set_list_item_widget.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<Widget> setListItems = <Widget>[]; // same as '= List<Widget>()'
  List<FlashcardsSet> flashcardsSetList = <FlashcardsSet>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Explore')),
        bottomNavigationBar: MenuBottom(),
        drawer: MenuDrawer(),
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/sea.jpg'),
              fit: BoxFit.cover,
            )),
            child: Center(
                child: Container(
              padding: const EdgeInsets.all(24),
              child: ListView(children: setListItems),
            ))));
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadAllFlashcardsSets();
    });
  }

  Future<void> loadAllFlashcardsSets() async {
    HttpHelper httpHelper = HttpHelper();
    flashcardsSetList = await httpHelper.getAllFlashcardsSet();

    for (var element in flashcardsSetList) {
      setListItems.add(SetListItemWidget(flashcardSet: element));
    }
  }
}
