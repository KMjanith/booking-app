class LoginModel {
  final String token;
  final bool isAdmin;
  final String userID;

  const LoginModel({
    required this.token,
    required this.isAdmin,
    required this.userID,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      token: json['token'],
      isAdmin: json['isAdmin'],
      userID: json['userID'],
    );
  }
}
