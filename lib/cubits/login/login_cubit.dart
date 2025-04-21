import 'package:electro_app_team/services/login_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';import '../../utils/shared_perefrences.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginService loginService;
  final StorageService storageService = StorageService();

  LoginCubit({required this.loginService}) : super(LoginInitial());

  void loginUser({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      final loginModel = await loginService.login(email: email, password: password);
      print("Token: ${loginModel.token}");
      await storageService.saveToken(loginModel.token);
      emit(LoginSuccess(token: loginModel.token));
    } catch (e) {
      emit(LoginError(message: e.toString()));
    }
  }



}

