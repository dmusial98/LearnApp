// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_app/shared/menu_bottom.dart';

import '../shared/menu_drawer.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

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
              child: ListView(children: [
                Container(
                    padding: const EdgeInsets.all(24),
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white70,
                    ),
                    child: const Text('Start screen',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 22, shadows: [
                          Shadow(
                              offset: Offset(1.0, 1.0),
                              blurRadius: 2.0,
                              color: Colors.grey)
                        ]))),
                Container(
                    padding: const EdgeInsets.all(24),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white70,
                    ),
                    child: const Text('Start screen',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 22, shadows: [
                          Shadow(
                              offset: Offset(1.0, 1.0),
                              blurRadius: 2.0,
                              color: Colors.grey)
                        ])))
              ]),
            ))));
  }
}
