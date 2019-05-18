class Credentials {
  Credentials(this.username, this.password);

  String username;
  String password;

  Map<String, dynamic> toJson() => {
        'data': {'username': username, 'password': password}
      };
}
