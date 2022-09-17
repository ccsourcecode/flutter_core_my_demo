// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class LocalStorageService {
  static LocalStorageService? _instance;
  static SharedPreferences? _preferences;
  static const String UserKey = 'user';
  static const String AppLanguagesKey = 'languages';
  static const String DarkModeKey = 'darkmode';
  static const bool _hasSignedUp = false;
  static const bool _hasLoggedIn = false;

  static Future<LocalStorageService> getInstance() async {
    _instance ??= LocalStorageService();
    _preferences ??= await SharedPreferences.getInstance();

    return _instance!;
  }

  dynamic _getFromDisk(String key) {
    var value = _preferences!.get(key);
    print('(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }

  void saveStringToDisk(String key, String content) {
    // for trace logging
    // trace through everything and check what code sets or reads these values
    print(
        '(TRACE) LocalStorageService:_saveStringToDisk. key: $key value: $content');
    _preferences!.setString(UserKey, content);
  }

  // -------------------------------------------------------------

  bool get darkMode => _getFromDisk(DarkModeKey) ?? false;
  set darkMode(bool value) => _saveToDisk(DarkModeKey, value);

// -------------------------------------------------------------

  bool get hasLoggedIn => _hasLoggedIn;
  bool get hasSignedUp => _hasSignedUp;

// -------------------------------------------------------------

  List<String> get languages => _getFromDisk(AppLanguagesKey) ?? <String>[];
  set languages(List<String> appLanguages) =>
      _saveToDisk(AppLanguagesKey, appLanguages);

// -------------------------------------------------------------

// updated _saveToDisk function that handles all types
  void _saveToDisk<T>(String key, T content) {
    print('(TRACE) LocalStorageService:_saveToDisk. key: $key value: $content');

    if (content is String) {
      _preferences!.setString(key, content);
    }
    if (content is bool) {
      _preferences!.setBool(key, content);
    }
    if (content is int) {
      _preferences!.setInt(key, content);
    }
    if (content is double) {
      _preferences!.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences!.setStringList(key, content);
    }
  }

// -------------------------------------------------------------
  User? get user {
    var userJson = _getFromDisk(UserKey);
    if (userJson == null) {
      return null;
    }

    return User.fromJson(jsonDecode(userJson));
  }

  set user(User? userToSave) {
    saveStringToDisk(UserKey, jsonEncode(userToSave?.toJson()));
  }
}
