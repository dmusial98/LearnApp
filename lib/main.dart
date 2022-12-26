import 'package:flutter/material.dart';
import 'package:my_app/screens/intro_screen.dart';

void main()
{
  runApp(const LearnApp());
}

// type 'stless'
class LearnApp extends StatelessWidget {
  const LearnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: IntroScreen()
    );
  }
}