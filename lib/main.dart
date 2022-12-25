import 'package:flutter/material.dart';

void main()
{
  runApp(const GlobeApp());
}

// type 'stless'
class GlobeApp extends StatelessWidget {
  const GlobeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Learn App')),
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
                'testestest',
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
                ))),
        )
        
      )
    );
  }
}