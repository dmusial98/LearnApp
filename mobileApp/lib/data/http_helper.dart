import 'package:http/http.dart' as http;

class HttpHelper {
  final String authority = ''; // api.openweathermap.org
  final String path = ''; // data/2.5/weather
  final String apiKey = ''; // 362713861276

  Future<String> getWeather(String location) async {
    Map<String, dynamic> parameters = {'q': location, 'appId': apiKey};
    Uri uri = Uri.https(authority, path, parameters);
    http.Response result = await http.get(uri);
    return result.body;
  }
}