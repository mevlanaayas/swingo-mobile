import 'package:flutter/foundation.dart';
import 'package:swingo/src/models/models.dart';

class UserStatus with ChangeNotifier {
  bool _userLoggedIn = true;
  User _user = User(id: 1, username: "currentuser");

  bool get userLoggedIn => _userLoggedIn;

  User get currentUser => _user;

  set userLoggedIn(bool newValue) {
    _userLoggedIn = newValue;
    notifyListeners();
  }

  set currentUser(User newUser) {
    _user = newUser;
    notifyListeners();
  }
}
