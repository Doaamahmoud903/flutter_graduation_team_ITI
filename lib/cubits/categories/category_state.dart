import '../../models/category_model.dart';

class IntialState{

}
class CategoryLoading extends IntialState{}
class CategoryLoaded extends IntialState{
  final List<CategoryModel> categories;
  CategoryLoaded({required this.categories});
}
class CategoryFailure extends IntialState{
   final String error;
  CategoryFailure({required this.error});

}
