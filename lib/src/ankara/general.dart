import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swingo/src/models/models.dart';

const SW_TOKEN_KEY = 'swUserToken';
const SW_USER_ID_KEY = 'swUserId';
const SW_USERNAME_KEY = 'swUsername';

class UserStatus with ChangeNotifier {
  User _user;
  String _token;

  User get currentUser => _user;

  String get token => _token;

  bool get isLoggedIn => _token != null && currentUser != null;

  set currentUser(User newUser) {
    _user = newUser;
    notifyListeners();
  }

  set token(String newToken) {
    _token = newToken;
    notifyListeners();
  }

  init() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString(SW_TOKEN_KEY) ?? null;
    int userId = prefs.getInt(SW_USER_ID_KEY) ?? null;
    String username = prefs.getString(SW_USERNAME_KEY) ?? null;
    if (userId != null && username != null) {
      currentUser = User(id: userId, username: username);
    }
  }

  signin(String newToken) {
    token = newToken;
    print(token);
    notifyListeners();
    _saveToSharedPreferences(SW_TOKEN_KEY, newToken);
  }

  auth(int userId, String username) async {
    currentUser = User(id: userId, username: username);
    notifyListeners();
    _saveToSharedPreferences(SW_USER_ID_KEY, userId);
    _saveToSharedPreferences(SW_USERNAME_KEY, username);
  }

  signout() {
    token = null;
    currentUser = null;
    notifyListeners();
    _saveToSharedPreferences(SW_TOKEN_KEY, null);
    _saveToSharedPreferences(SW_USER_ID_KEY, null);
    _saveToSharedPreferences(SW_USERNAME_KEY, null);
  }

  _saveToSharedPreferences(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is String) {
      prefs.setString(key, value);
    } else if (value is int) {
      prefs.setInt(key, value);
    }
    print('saved $value');
  }
}
