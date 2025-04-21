import 'package:electro_app_team/models/product_model.dart';

abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<ProductModel> products;
  ProductsLoaded({required this.products});
}

class ProductsFailure extends ProductsState {
  final String error;
  ProductsFailure({required this.error});
}

class ProductsEmpty extends ProductsState {}
