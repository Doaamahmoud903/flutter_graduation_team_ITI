import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());
  String baseUrl = "https://e-commerce-node-seven.vercel.app/api/v1";
  Future<void> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    print('🚀 Sending reset password request:');
    print('📧 Email: $email');
    print('🔐 Code: $code');
    print('🔁 New Password: $newPassword');

    emit(ResetPasswordLoading());
    try {
      final response = await Dio().put(
        "$baseUrl/auth/reset-password",
        data: {
          "code": code,
          "email": email,
          "newPassword": newPassword,
        },
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        emit(ResetPasswordSuccess(message: response.data['message']));
      } else {
        emit(ResetPasswordError(message: response.data['message'] ?? "Reset failed"));
      }
    } catch (e) {
      log(e.toString());
      emit(ResetPasswordError(message: "Something went wrong!"));
    }
  }
}