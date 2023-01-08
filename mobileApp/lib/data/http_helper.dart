import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_app/data/user.dart';

class HttpHelper {
  final String authority = 'localhost:5000'; // api.openweathermap.org
  final String path = 'api/Users/1/'; // data/2.5/weather
  final String apiKey = ''; // 362713861276

  Future<User> getUser() async {
    //Map<String, dynamic> parameters = {'appId': apiKey};
    Uri uri = Uri.http(authority, path);
    http.Response result = await http.get(uri);
    Map<String, dynamic> data = json.decode(result.body);
    User user = User.fromJson(data);
    return user;
  }
}
