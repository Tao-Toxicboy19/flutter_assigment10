class User {
  final String username;
  final String password;
  final String? email;
  final String? shopName;
  User({
    this.email,
    this.shopName,
    required this.username,
    required this.password,
  });
}
