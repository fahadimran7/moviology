class User {
  final String? fullName;
  final String? email;

  User({
    this.fullName,
    this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullName: json['fullName'],
      email: json['email'],
    );
  }
}
