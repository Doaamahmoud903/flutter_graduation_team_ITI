import 'package:dio/dio.dart';
import 'package:electro_app_team/cubits/categories/category_state.dart';
import 'package:electro_app_team/models/category_model.dart';
import 'package:electro_app_team/services/category_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCubit extends Cubit<IntialState> {
  CategoryCubit() : super(IntialState());

  // Create an instance of service
  final CategoryService categoryService = CategoryService(dio: Dio());

  List<CategoryModel> categories = [];

  Future<void> getFetchedCategories() async {
    emit(CategoryLoading());
    try {
      final result = await categoryService.getAllCategories();
        categories = result;
        emit(CategoryLoaded(categories: categories));

    } catch (e) {
      emit(CategoryFailure(error: e.toString()));
    }
  }
}
