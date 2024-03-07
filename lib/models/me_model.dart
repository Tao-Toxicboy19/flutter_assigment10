class Me {
  String email;
  DateTime exp;
  DateTime iat;
  String iss;
  String shopName;
  String sub;
  String username;

  Me({
    required this.email,
    required this.exp,
    required this.iat,
    required this.iss,
    required this.shopName,
    required this.sub,
    required this.username,
  });

  factory Me.fromJson(Map<String, dynamic> json) => Me(
        email: json["email"],
        exp: DateTime.fromMillisecondsSinceEpoch(json["exp"] * 1000),
        iat: DateTime.fromMillisecondsSinceEpoch(json["iat"] * 1000),
        iss: json["iss"],
        shopName: json["shopName"],
        sub: json["sub"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "exp": exp.millisecondsSinceEpoch ~/ 1000,
        "iat": iat.millisecondsSinceEpoch ~/ 1000,
        "iss": iss,
        "shopName": shopName,
        "sub": sub,
        "username": username,
      };
}
