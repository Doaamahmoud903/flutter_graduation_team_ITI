import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/register_service.dart';
import 'register_state.dart';
import 'package:flutter/material.dart';


class RegisterCubit extends Cubit<RegisterState> {
  final RegisterService registerService;

  RegisterCubit(this.registerService) : super(RegisterInitial());

  static RegisterCubit get(BuildContext context) =>
      BlocProvider.of<RegisterCubit>(context);

  Future<void> registerUser({
    required String name,
    required String email,
    required String phone,
    required String address,
    required String password,
    required String confirmPassword,
  }) async {
    emit(RegisterLoading());

    try {
      final registerModel = await registerService.register(
        name: name,
        email: email,
        password: password,
        phone: phone,
        address: address,
          confirmPassword:confirmPassword,
      );
      emit(RegisterSuccess(registerModel));
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}
