class Signin {
  final String username;
  final String password;

  Signin({this.username, this.password});

  static String toJson(String username, String password) {
    return '{"username": "${username}", "password": "${password}"}';
  }
}