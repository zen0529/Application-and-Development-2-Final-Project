class User {
  String username;
  String fullName;
  String email;
  String password;

  User(
      {required this.username,
      required this.fullName,
      required this.email,
      required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      fullName: json['full_name'],
      email: json['email'],
      password: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'full_name': fullName,
      'email': email,
      'password': password,
    };
  }
}
