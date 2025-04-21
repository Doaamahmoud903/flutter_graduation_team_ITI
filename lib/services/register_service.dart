import 'package:dio/dio.dart';
import 'package:electro_app_team/models/register_model.dart';
import 'dart:developer';  // تأكدي من إضافة هذه المكتبة

class RegisterService {
  final Dio dio;
  RegisterService({required this.dio});
  String baseUrl = "https://e-commerce-node-seven.vercel.app/api/v1";

  Future<RegisterModel> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String address,
    required String confirmPassword,

  }) async {
    try {
      final response = await dio.post(
        '$baseUrl/auth/register',
        data: {
          "name": name,
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword,
          "phone": phone,
          "address": address,
        },
      );

      print('Response Data: ${response.data}');

      if (response.statusCode == 200 && response.data['success'] == true) {
        return RegisterModel.fromJson(response.data);
      } else {
        throw Exception(response.data['message'] ?? 'Registration failed');
      }
    } on DioException catch (e) {
      final String errorMessage =
          e.response?.data['message'] ?? "Oops, there is an error";
      throw Exception(errorMessage);
    } catch (e) {
      log("Exception: ${e.toString()}");
      throw Exception("Unexpected error occurred");
    }
  }
}
