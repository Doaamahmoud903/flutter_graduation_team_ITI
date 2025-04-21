class LoginModel {
  final String token;
  final String name;
  final String email;

  LoginModel({required this.token, required this.name, required this.email});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      token: json['token'].toString() ?? "",
      name: json['user']['name'].toString() ?? "",
      email: json['user']['email'].toString() ?? "",
    );
  }
}
