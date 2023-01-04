// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_app/shared/menu_bottom.dart';

import '../shared/menu_drawer.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add')),
      bottomNavigationBar: MenuBottom(),
      drawer: MenuDrawer(),
      body: Center(child: FlutterLogo())
    );
  }
}