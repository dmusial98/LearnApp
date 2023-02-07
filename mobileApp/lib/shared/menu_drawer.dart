// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:my_app/screens/edit_profile_screen.dart';
import '../screens/login_screen.dart';
import '../screens/search_screen.dart';
import '../screens/own_screen.dart';
import '../screens/flashcards_set_screen.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: buildMenuItems(context),
    ));
  }

  List<Widget> buildMenuItems(BuildContext context) {
    final List<String> menuTitles = [
      'Main',
      'Flashcards set',
      'Edit account',
      'About us',
      'Log out'
    ];

    List<Widget> menuItems = [];

    menuItems.add(const DrawerHeader(
        decoration: BoxDecoration(color: Colors.blueGrey),
        child: Text('Learn App',
            style: TextStyle(color: Colors.white, fontSize: 28))));

    for (var element in menuTitles) {
      Widget screen = Container();
      menuItems.add(
        ListTile(
            title: Text(element, style: const TextStyle(fontSize: 18)),
            onTap: () {
              switch (element) {
                case 'Main':
                  screen = const OwnScreen();
                  break;
                case 'Flashcards set':
                  screen = const FlashcardsSetScreen();
                  break;
                case 'Edit account':
                  screen = const EditProfileScreen();
                  break;
                case 'About us':
                  screen = const SearchScreen();
                  break;
                case 'Log out':
                  screen = const LoginScreen();
                  break;
              }
              if (element == 'Log out') {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (route) => false);
              } else {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => screen));
              }
            }),
      );
    }

    return menuItems;
  }
}
