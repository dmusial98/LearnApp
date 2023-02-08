import 'package:flutter/material.dart';

class TestItem extends StatelessWidget {
  final String text;
  const TestItem({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          left: 32.0, right: 32.0, top: 20.0, bottom: 0.0),
      width: 700,
      height: 80,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white70,
      ),
      padding: const EdgeInsets.all(20),
      child: Container(
        alignment: Alignment.centerLeft,
        child: Text(text,
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 22, shadows: [
              Shadow(
                  offset: Offset(1.0, 1.0), blurRadius: 2.0, color: Colors.grey)
            ])),
      ),
    );
  }
}
