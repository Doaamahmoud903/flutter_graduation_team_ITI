import 'package:dio/dio.dart';
import '../models/login_model.dart';

class LoginService {
  final Dio dio;
  LoginService({required this.dio});
  String baseUrl = "https://e-commerce-node-seven.vercel.app/api/v1";

  Future<LoginModel> login({required String email, required String password}) async {
    final response = await dio.post(
      '$baseUrl/auth/login',
      data: {
        'email': email,
        'password': password,
      },
    );

    print('Response Data: ${response.data}');

    if (response.statusCode == 200 && response.data['success'] == true) {
      return LoginModel.fromJson(response.data);
    } else {
      throw Exception(response.data['message'] ?? 'Login failed');
    }
  }
}
