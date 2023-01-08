// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_app/data/http_helper.dart';
import 'package:my_app/shared/menu_bottom.dart';

import '../data/user.dart';
import '../shared/menu_drawer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";
  String password = "";

  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Log')),
        bottomNavigationBar: MenuBottom(),
        drawer: MenuDrawer(),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextField(
                  controller: txtEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: 'Your e-mail address')),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextField(
                  controller: txtPassword,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Your password')),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: ElevatedButton(onPressed: signIn, child: Text('Sign in')),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: ElevatedButton(
                  onPressed: signUp,
                  child: Text('I want to create new account')),
            ),
            Text("Debug info: E-mail: $email Password: $password")
          ]),
        ));
  }

  Future signIn() async {
    //password = txtPassword.text;
    HttpHelper httpHelper = HttpHelper();
    User tmpUser = await httpHelper.getUser();
    email = tmpUser.Email;
    password = tmpUser.Password;

    setState(() {
      //email = txtEmail.text;
    });
  }

  void signUp() {
    Navigator.pushNamed(context, '/register');
  }
}
