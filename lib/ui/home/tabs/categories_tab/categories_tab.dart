import 'package:dio/dio.dart';
import 'package:electro_app_team/ui/home/tabs/categories_tab/side_menu.dart';
import 'package:flutter/material.dart';

import '../../../../models/category_model.dart';
import '../../../../services/category_service.dart';
import '../../../../widgets/main_appbar.dart';
import 'content_area.dart';
class CategoriesTab extends StatefulWidget {
  const CategoriesTab({super.key});
  static const String routeName = "CategoriesTab";

  @override
  State<CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab> {
  String? selectedCategoryName;
  String? selectedCategoryId;
  String? selectedCategoryImage;
  late Future<List<CategoryModel>> categoriesFuture;

  @override
  void initState() {
    super.initState();
    final categoryService = CategoryService(dio: Dio());
    categoriesFuture = categoryService.getAllCategories().then((categories) {
      if (categories.isNotEmpty) {
        // Automatically select the first category
        final firstCategory = categories[0];
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            selectedCategoryName = firstCategory.name;
            selectedCategoryId = firstCategory.id;
            selectedCategoryImage = firstCategory.image;
          });
        });
      }
      return categories;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;


    return Scaffold(
      appBar: MainAppbar(width: width, height: height),
      body: Row(
        children: [
          // Side Menu
          Expanded(
            flex: 1,
            child: SideMenu(
              onCategorySelected: (name, id, image) {
                setState(() {
                  selectedCategoryName = name;
                  selectedCategoryId = id;
                  selectedCategoryImage = image;
                });
              },
              initialCategoryId: selectedCategoryId,
            ),
          ),

          // Content Area
          Expanded(
            flex: 3,
            child: Builder(
              builder: (context) {
                if (selectedCategoryName == null ||
                    selectedCategoryId == null ||
                    selectedCategoryImage == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ContentArea(
                  categoryName: selectedCategoryName!,
                  categoryId: selectedCategoryId!,
                  categoryImage: selectedCategoryImage!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
