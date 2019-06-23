import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swingo/src/models/models.dart';

class UserStatus with ChangeNotifier {
  String _token;
  bool _userLoggedIn = false;
  User _user = User(id: 1, username: "currentuser");

  bool get userLoggedIn => _userLoggedIn;

  User get currentUser => _user;

  String get token => _token;

  bool get isLoggedIn => _token != null;

  set userLoggedIn(bool newValue) {
    _userLoggedIn = newValue;
    notifyListeners();
  }

  set currentUser(User newUser) {
    _user = newUser;
    notifyListeners();
  }

  set token(String newToken) {
    _token = newToken;
    notifyListeners();
  }

  init() async {
    _token = await _loadFromSharedPreferences('swUserToken');
  }

  signin(String newToken) {
    token = newToken;
    _saveToSharedPreferences('swUserToken', newToken);
  }

  signout() {
    token = null;
    _saveToSharedPreferences('swUserToken', token);
  }

  _loadFromSharedPreferences(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(key) ?? null;
    print('read: $value');
    return value;
  }

  _saveToSharedPreferences(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    print('saved $value');
  }
}
