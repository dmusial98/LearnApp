import 'package:flutter/material.dart';

class SetListItemWidget extends StatelessWidget {
  final String title;
  const SetListItemWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(24),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white70,
        ),
        child: Text('Start screen: $title',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, shadows: [
              Shadow(
                  offset: Offset(1.0, 1.0), blurRadius: 2.0, color: Colors.grey)
            ])));
  }
}
