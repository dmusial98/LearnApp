import 'package:flutter/material.dart';

class QuestionTestItem extends StatelessWidget {
  final String text;
  const QuestionTestItem({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          left: 32.0, right: 32.0, top: 20.0, bottom: 0.0),
      width: 700,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: Colors.white70,
        border: Border.all(width: 5, color: Colors.grey),
      ),
      child: Center(
          child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  style: const TextStyle(fontSize: 32, shadows: [
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
}
