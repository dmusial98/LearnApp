// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_app/shared/menu_bottom.dart';

import '../shared/menu_drawer.dart';

class FlashcardSetScreen extends StatelessWidget {
  const FlashcardSetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    return Scaffold(
        appBar: AppBar(title: Text(arguments['flashcardSetID'].toString())),
        //bottomNavigationBar: MenuBottom(),
        //drawer: MenuDrawer(),
        body: Center(child: FlutterLogo()));
  }
}
//flashcardSetID