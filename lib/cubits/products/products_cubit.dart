import 'package:electro_app_team/cubits/products/products_state.dart';
import 'package:electro_app_team/models/product_model.dart';
import 'package:electro_app_team/services/product_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());

  final ProductService productService = ProductService(dio: Dio());
  List<ProductModel> allProducts = []; // Original products list
  List<ProductModel> filteredProducts = []; // Products after filtering

  Future<void> getFetchedProducts() async {
    try {
      emit(ProductsLoading());
      allProducts = await productService.getAllProducts();
      filteredProducts = allProducts; // Initialize with all products
      emit(ProductsLoaded(products: filteredProducts));
    } catch (e) {
      emit(ProductsFailure(error: e.toString()));
    }
  }

  Future<void> fetchProductsWithSearch(String query) async {
    try {
      emit(ProductsLoading());
      final results = await productService.searchProducts(query);
      if (results.isEmpty) {
        emit(ProductsEmpty());
      } else {
        emit(ProductsLoaded(products: results));
      }
    } catch (e) {
      emit(ProductsFailure(error: e.toString()));
    }
  }

}