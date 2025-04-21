import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:electro_app_team/models/product_model.dart';

class ProductService {
  final Dio dio;
  ProductService({required this.dio});
  String baseUrl = "https://e-commerce-node-seven.vercel.app/api/v1";

  Future <List<ProductModel>>getAllProducts() async{
    try{
      Response response = await dio.get("$baseUrl/products");
      log("API Response is ${response.data.toString()}");

      List<dynamic> productsService = response.data["products"];

      List<ProductModel> productsList = productsService
          .map((productJson) => ProductModel.fromJson(productJson))
          .toList();
      log("Success , Product Length = ${productsList.length.toString()}");
      return productsList;
    }on DioException catch(e){
      final String errorMessage =
          e.response?.data['message'] ?? "Oops there is an Error";
      return [];
    }catch(e){
      log("Exception: ${e.toString()}");
      return [];
    }
  }

  Future<List<ProductModel>> getProductsByCategory(String categoryId) async {
    try {
      log("Fetching products for category ID: $categoryId");
      final response = await dio.get(
        "$baseUrl/products",
        queryParameters: {
          "category": categoryId,
        },
      );
      log("Full API Response: ${response.data}");

      if (response.data["products"] == null) {
        log("No 'products' field in response");
        return [];
      }

      List<dynamic> productsService = response.data["products"];
      log("Number of products received: ${productsService.length}");

      List<ProductModel> productsList = productsService
          .map((productJson) => ProductModel.fromJson(productJson))
          .toList();

      log("Successfully parsed ${productsList.length} products");
      return productsList;
    } on DioException catch (e) {
      log("Dio Error: ${e.message}");
      log("Response data: ${e.response?.data}");
      log("Status code: ${e.response?.statusCode}");
      return [];
    } catch (e) {
      log("General Error: $e");
      return [];
    }
  }

  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      final response = await dio.get(
        '$baseUrl/products',
        queryParameters: {'search': query},
      );
      final List data = response.data['products'];
      return data.map((e) => ProductModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Failed to search products: $e");
    }
  }


}

