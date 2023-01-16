// ignore_for_file: non_constant_identifier_names

class GlobalDataSingleton {
  static final GlobalDataSingleton _singleton = GlobalDataSingleton._internal();

  factory GlobalDataSingleton() {
    return _singleton;
  }

  GlobalDataSingleton._internal();

  int LoggedUserId = 0;
}
