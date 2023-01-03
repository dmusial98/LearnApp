// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import '../screens/search_screen.dart';
import '../screens/own_screen.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: buildMenuItems(context),
      )
    );
  }

  List<Widget> buildMenuItems(BuildContext context)
  {
    final List<String> menuTitles = [
      'Home',
      'BMI Calculator',
      'Weather',
      'Training'
    ];

    List<Widget> menuItems = [];

    menuItems.add(const DrawerHeader(
      decoration: BoxDecoration(color: Colors.blueGrey),
      child: Text('Learn App',
      style: TextStyle(color: Colors.white, fontSize: 28))
    ));
    
    for (var element in menuTitles) {
      Widget screen = Container();
      menuItems.add(ListTile(
        title: Text(element, style: const TextStyle(fontSize: 18)), 
        onTap: () {
          switch(element) {
            case 'Home':
              screen = const OwnScreen();
              break;
            case 'BMI Calculator':
              screen = const SearchScreen();
              break;
          }
          Navigator.of(context).pop();
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => screen));
         }),
      );
    }

    return menuItems;
  }
}