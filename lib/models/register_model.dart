class RegisterModel {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String password;
  final String confirmPassword;

  RegisterModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.password,
    required this.confirmPassword,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      name: json['user']['name'].toString() ?? "",
      email: json['user']['email'].toString() ?? "",
      phone: json['user']['phone'].toString() ?? "",
      address: json['user']['address'].toString() ?? "",
      password: json['user']['password'].toString() ?? "",
      confirmPassword: json['user']['confirmPassword'].toString() ?? "",
    );
  }
}
