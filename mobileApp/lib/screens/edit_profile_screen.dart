// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_app/data/global_data_singleton.dart';
import 'package:my_app/data/http_helper.dart';
import '../data/http_helper.dart';
import '../data/http_helper.dart';
import '../data/http_helper.dart';
import '../data/http_helper.dart';
import '../data/http_helper.dart';
import '../data/user.dart';
import '../shared/menu_drawer.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  GlobalDataSingleton globalDataSingleton = GlobalDataSingleton();

  String email = "";
  String password = "";
  String errorMessage = '';

  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();
  final TextEditingController txtConfirmPassword = TextEditingController();
  final TextEditingController txtPhoneNumber = TextEditingController();
  final TextEditingController txtFacebookLink = TextEditingController();
  final TextEditingController txtTwitterLink = TextEditingController();
  final TextEditingController txtAboutMe = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Edit profile')),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextField(
                  controller: txtEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: 'Your e-mail address')),
            ),
            /*Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextField(
                  controller: txtPassword,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Your password')),
            ),*/
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextField(
                  controller: txtPhoneNumber,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(hintText: 'Your phone number')),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextField(
                  controller: txtFacebookLink,
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(hintText: 'Your Facebook link')),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextField(
                  controller: txtTwitterLink,
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(hintText: 'Your Twitter link')),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextField(
                  controller: txtAboutMe,
                  keyboardType: TextInputType.url,
                  decoration: InputDecoration(hintText: 'About Me section')),
            ),
            Padding(
                padding: const EdgeInsets.all(32.0),
                child: Row(children: [
                  ElevatedButton(onPressed: editUser, child: Text('Edit')),
                ])),
            Text("Edited user's ID: ${globalDataSingleton.LoggedUserId}")
          ]),
        ));
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadUserData();
    });
  }

  void loadUserData() async {
    HttpHelper httpHelper = HttpHelper();
    try {
      GlobalDataSingleton global = GlobalDataSingleton();
      User tmpUser = await httpHelper.getUserById(global.LoggedUserId);
      txtEmail.text = tmpUser.Email;
      txtPhoneNumber.text = tmpUser.PhoneNumber;
      txtFacebookLink.text = tmpUser.FacebookLink;
      txtTwitterLink.text = tmpUser.TwitterLink;
      txtAboutMe.text = tmpUser.AboutMe;
    } catch (e) {
      errorMessage = 'USER NOT FOUND: $e';
      Navigator.pop(context);
    }
  }

  void editUser() {}
}
