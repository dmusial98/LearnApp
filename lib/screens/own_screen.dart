// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import '../shared/menu_drawer.dart';
import '../shared/menu_bottom.dart';

class OwnScreen extends StatelessWidget {
  const OwnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Own')),
        drawer: const MenuDrawer(),
        bottomNavigationBar: MenuBottom(),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage( 
              image: AssetImage('assets/sea.jpg'),
              fit: BoxFit.cover,
            )
          ),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white70,
              ),
              child: const Text(
                'Start screen',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  shadows: [
                    Shadow(
                      offset: Offset(1.0, 1.0),
                      blurRadius: 2.0,
                      color: Colors.grey
                    )
                  ]
                )
              )
            )
          )
        )
      );
  }
}