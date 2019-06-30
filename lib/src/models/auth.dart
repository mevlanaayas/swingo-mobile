class Auth {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String userName;

  Auth(
      this.id,
      this.email,
      this.firstName,
      this.lastName,
      this.userName,);

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      json['pk'],
      json['email'],
      json['first_name'],
      json['last_name'],
      json['username'],
    );
  }
}
