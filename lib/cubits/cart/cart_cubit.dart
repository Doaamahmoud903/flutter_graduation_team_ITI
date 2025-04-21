import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:electro_app_team/cubits/cart/cart_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://e-commerce-node-seven.vercel.app/api/v1/',
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  Future<void> addToCart(String productId) async {
    emit(CartLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('user_token');

      if (token == null) {
        emit(CartFailure("No token found"));
        return;
      }

      final response = await dio.post(
        'cart',
        data: {"productId": productId},
        options: Options(headers: {"token": "Bearer $token"}),
      );

      emit(CartSuccess(response.data));
    } catch (e) {
      emit(CartFailure(e.toString()));
    }
  }
}
