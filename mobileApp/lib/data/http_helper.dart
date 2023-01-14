import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_app/data/user.dart';

class HttpHelper {
  final String authority = 'localhost:5000'; // api.openweathermap.org
  final String path = 'api/Users/byPassword'; // api/Users/1/
  final String apiKey = ''; // 362713861276

  Future<User> getUser(String email, String password) async {
    Map<String, dynamic> parameters = {'email': email, 'password': password};
    Uri uri = Uri.http(authority, path, parameters);
    http.Response result = await http.get(uri);
    Map<String, dynamic> data = json.decode(result.body);
    User user = User.fromJson(data);
    return user;
  }
}
