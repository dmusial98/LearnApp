// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_app/data/http_helper.dart';
import 'package:my_app/shared/menu_bottom.dart';

import '../data/validator.dart';
import '../shared/menu_drawer.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String email = "";
  String password = "";
  String errorMessage = '';

  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();
  final TextEditingController txtConfirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Registration')),
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
              padding: const EdgeInsets.all(24.0),
              child: TextField(
                  controller: txtConfirmPassword,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration:
                      InputDecoration(hintText: 'Confirm your password')),
            ),
            Padding(
                padding: const EdgeInsets.all(32.0),
                child: Row(children: [
                  ElevatedButton(onPressed: register, child: Text('Register')),
                ])),
            Text(errorMessage)
          ]),
        ));
  }

  Future register() async {
    errorMessage = '';

    if (Validator.validateEmail(txtEmail.text)) {
      email = txtEmail.text;
    } else {
      errorMessage += ' Wrong e-mail address format!';
    }

    if (Validator.validatePassword(txtPassword.text) &&
        txtPassword.text == txtConfirmPassword.text) {
      password = Validator.hashPassword(txtPassword.text);
    } else {
      errorMessage += ' Wrong password format!';
    }

    if (errorMessage.isEmpty) {
      HttpHelper httpHelper = HttpHelper();
      try {
        await httpHelper.createNewUser(email, password);
        //Navigator.pushNamed(context, '/own');
      } catch (e) {
        errorMessage = 'USER HAS BEEN NOT CREATED: $e';
      }
      setState(() {});
    }
  }
}
