import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_app/data/user.dart';

class HttpHelper {
  final String authority = '10.0.2.2:5000'; // api.openweathermap.org
  //final String path = ; // api/Users/1/
  final String apiKey = ''; // 362713861276

  Future<User> getUser(String email, String password) async {
    Map<String, dynamic> parameters = {'email': email, 'password': password};

    Uri uri = Uri.http(authority, 'api/Users/byPassword', parameters);
    http.Response result = await http.get(uri);

    if (result.statusCode != 200) throw Exception('User error');

    Map<String, dynamic> data = json.decode(result.body);
    User user = User.fromJson(data);
    return user;
  }

  Future<void> createNewUser(String email, String password) async {
    User newUser = User(0, false, email, password, '', '', '', 'New user!');
    String jsonNewUser = jsonEncode(newUser);

    Uri uri = Uri.http(authority, 'api/Users/');

    http.Response result = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonNewUser,
    );
    if (result.statusCode != 201) throw Exception(result.body);
  }
}
