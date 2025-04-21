import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:electro_app_team/models/category_model.dart';

class CategoryService{
  final Dio dio;
  CategoryService({required this.dio});
  String baseUrl = "https://e-commerce-node-seven.vercel.app/api/v1";
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      Response response = await dio.get("$baseUrl/categories");
      log("API Response: ${response.data.toString()}");

      final List<dynamic> categoriesJson = response.data['categories'];

      List<CategoryModel> categories = categoriesJson
          .map((categoryJson) => CategoryModel.fromJson(categoryJson))
          .toList();

      log("success - categories count: ${categories.length}");
      return categories;
    } on DioException catch (e) {
      final String errorMessage =
          e.response?.data['message'] ?? "Oops there is an Error";
      log("DioException: $errorMessage");
      return [];
    } catch (e) {
      log("Exception: ${e.toString()}");
      return [];
    }
  }

}