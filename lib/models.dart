class User {
  final String username;
  final String fullname;
  final String email;
  final String token;

  User(
      {required this.username,
      required this.fullname,
      required this.email,
      required this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      fullname: json['fullname'],
      email: json['email'],
      token: json['token'],
    );
  }
}
