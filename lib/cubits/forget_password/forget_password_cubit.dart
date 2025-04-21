import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final Dio dio;

  ForgetPasswordCubit({required this.dio}) : super(ForgetPasswordInitial());

  Future<void> sendForgetPasswordEmail(String email) async {
    emit(ForgetPasswordLoading());
    String baseUrl = "https://e-commerce-node-seven.vercel.app/api/v1";

    try {
      final response = await dio.post(
        "$baseUrl/auth/forgot-password",
        data: {"email": email},
      );

      final isSuccess = response.data['success'] == true;
      final message = response.data['message'] ?? 'Unknown response';

      if (isSuccess) {
        emit(ForgetPasswordSuccess(message: message));
      } else {
        emit(ForgetPasswordError(message: message));
      }
    } on DioException catch (e) {
      emit(ForgetPasswordError(
          message: e.response?.data['message'] ?? 'Network error'));
    } catch (e) {
      emit(ForgetPasswordError(message: "Unexpected error occurred"));
    }
  }
}
