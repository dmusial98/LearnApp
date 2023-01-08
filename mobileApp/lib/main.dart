import 'package:flutter/material.dart';
import 'package:my_app/screens/add_screen.dart';
import 'package:my_app/screens/edit_profile_screen.dart';
import 'package:my_app/screens/explore_screen.dart';
import 'package:my_app/screens/login_screen.dart';
import 'package:my_app/screens/register_screen.dart';
import 'package:my_app/screens/search_screen.dart';
import 'package:my_app/screens/own_screen.dart';

import 'screens/favourite_screen.dart';

void main() {
  runApp(const LearnApp());
}

// type 'stless'
class LearnApp extends StatelessWidget {
  const LearnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          brightness: Brightness.light,
        ),
        routes: {
          '/': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/own': (context) => const OwnScreen(),
          '/search': (context) => const SearchScreen(),
          '/explore': (context) => const ExploreScreen(),
          '/add': (context) => const AddScreen(),
          '/favourites': (context) => const FavouriteScreen(),
          '/edit_profile': (context) => const EditProfileScreen()
        });
  }
}
