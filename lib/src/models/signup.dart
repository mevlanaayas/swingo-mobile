class Signup {
  final String username;
  final String email;
  final String password;
  final String confirmPassword;

  Signup({this.username, this.email, this.password, this.confirmPassword});

  factory Signup.fromJson(Map<String, dynamic> json) {
    return Signup(
      username: json['username'],
      email: json['email'],
      password: json['password1'],
      confirmPassword: json['password2'],
    );
  }

  static String toJson(String username, String email, String password, String confirmPassword) {
    /*Map<String, dynamic> json;
    json['username'] = username;
    json['email'] = email;
    json['password1'] = password;
    json['password2'] = confirmPassword;
    */
    return '{"username": "${username}", "email": "${email}", "password1": "${password}", "password2": "${confirmPassword}"}';
  }

}