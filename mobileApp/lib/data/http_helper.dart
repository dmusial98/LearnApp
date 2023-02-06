import 'package:http/http.dart' as http;
import 'package:my_app/data/flashcards_set.dart';
import 'dart:convert';
import 'dart:io' show Platform;
import 'package:my_app/data/user.dart';
import 'package:my_app/data/flashcard.dart';

class HttpHelper {
  String authority = ''; // api.openweathermap.org
  //final String path = ; // api/Users/1/
  final String apiKey = ''; // 362713861276

  HttpHelper() {
    if (Platform.isAndroid) {
      authority = '10.0.2.2:5000';
    } else {
      authority = 'localhost:5000';
    }
  }

  Future<User> getUser(String email, String password) async {
    Map<String, dynamic> parameters = {'email': email, 'password': password};

    Uri uri = Uri.http(authority, 'api/Users/byPassword', parameters);
    http.Response result = await http.get(uri);

    if (result.statusCode != 200) throw Exception('User error');

    Map<String, dynamic> data = json.decode(result.body);
    User user = User.fromJson(data);
    return user;
  }

  Future<User> getUserById(int Id) async {
    Uri uri = Uri.http(authority, 'api/Users/$Id');
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

  Future<void> updateUserData(User user) async {
    String jsonUpdatedUser = jsonEncode(user);

    Uri uri = Uri.http(authority, 'api/Users/${user.Id}');

    http.Response result = await http.put(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonUpdatedUser,
    );
    if (result.statusCode != 200) {
      throw Exception('User could not be edited! ${result.reasonPhrase}');
    }
  }

  Future<FlashcardsSet> getFlashcardsSetsByEditor(int editorId) async {
    Map<String, dynamic> parameters = {'editorId': editorId};

    Uri uri = Uri.http(authority, 'api/flashcardsSets/byEditor', parameters);
    http.Response result = await http.get(uri);

    if (result.statusCode != 200) throw Exception('Flashcards set error');

    Map<String, dynamic> data = json.decode(result.body);
    FlashcardsSet set = FlashcardsSet.fromJson(data);
    return set;
  }

  Future<FlashcardsSet> getFlashcardsSetById(
      int id, bool withFlashcards) async {
    Map<String, dynamic> parameters = {
      'withFlashcards': withFlashcards.toString()
    };
    Uri uri = Uri.http(authority, 'api/flashcardsSets/${id}', parameters);
    http.Response result = await http.get(uri);

    if (result.statusCode != 200) throw Exception('Flashcards set error');

    Map<String, dynamic> data = json.decode(result.body);
    FlashcardsSet set = FlashcardsSet.fromJson(data);
    return set;
  }

  Future<Flashcard> getFlashcardById(int id) async {
    Uri uri = Uri.http(authority, 'api/flashcards/${id}');
    http.Response result = await http.get(uri);

    if (result.statusCode != 200) throw Exception('Flashcard error');

    Map<String, dynamic> data = json.decode(result.body);
    Flashcard flashcard = Flashcard.fromJson(data);
    return flashcard;
  }

  Future<List<FlashcardsSet>> getAllFlashcardsSet() async {
    Uri uri = Uri.http(authority, 'api/FlashcardsSets');
    http.Response result = await http.get(uri);

    if (result.statusCode != 200) throw Exception('Flashcard sets GET error');

    List<dynamic> list = json.decode(result.body);
    List<FlashcardsSet> flashcardsSetList = <FlashcardsSet>[];
    for (var element in list) {
      flashcardsSetList.add(FlashcardsSet.fromJson(element));
    }
    return flashcardsSetList;
  }
}
