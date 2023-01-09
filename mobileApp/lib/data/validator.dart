import 'package:crypto/crypto.dart';
import 'dart:convert';

class Validator {
  static final RegExp expEmail = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static final RegExp expPassword = RegExp(r'[a-zA-Z0-9]{8,}');

  static bool validateEmail(String email) => expEmail.hasMatch(email);

  static bool validatePassword(String password) =>
      expPassword.hasMatch(password);

  static String hashPassword(String password) {
    var bytes = utf8.encode(password); // data being hashed
    return sha256.convert(bytes).toString();
  }
}
