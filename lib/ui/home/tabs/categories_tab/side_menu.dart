import 'package:dio/dio.dart';
import 'package:electro_app_team/providers/theme_provider.dart';
import 'package:electro_app_team/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../../models/category_model.dart';
import '../../../../services/category_service.dart';

class SideMenu extends StatefulWidget {
  final Function(String categoryName, String categoryId, String imageUrl) onCategorySelected;
  final String? initialCategoryId;

  const SideMenu({
    super.key,
    required this.onCategorySelected,
    this.initialCategoryId,
  });

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  late final CategoryService _categoryService;
  late Future<List<CategoryModel>> _categoriesFuture;
  String? _selectedCategoryId;

  @override
  void initState() {
    super.initState();
    _categoryService = CategoryService(dio: Dio());
    _categoriesFuture = _fetchCategories();
    _selectedCategoryId = widget.initialCategoryId;
  }

  Future<List<CategoryModel>> _fetchCategories() async {
    try {
      final categories = await _categoryService.getAllCategories();
      // If we have an initial category ID but it's not selected yet
      if (widget.initialCategoryId != null && _selectedCategoryId == null) {
        _selectedCategoryId = widget.initialCategoryId;
      }
      return categories;
    } catch (e) {
      debugPrint('Error fetching categories: $e');
      rethrow;
    }
  }

  @override
  void didUpdateWidget(SideMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialCategoryId != widget.initialCategoryId) {
      _selectedCategoryId = widget.initialCategoryId;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SizedBox(
      height: height,
      child: Container(
        decoration: BoxDecoration(
            color: themeProvider.currentTheme == ThemeMode.dark
                ? AppColors.primaryColor
                : AppColors.lightPrimaryColor,
            border: Border(
                top: BorderSide(
                    color: themeProvider.currentTheme == ThemeMode.dark
                        ? AppColors.darkBlueColor
                        : AppColors.primaryColor,
                    width: 1
                )
            )
        ),
        child: FutureBuilder<List<CategoryModel>>(
          future: _categoriesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                height: 100,
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '${AppLocalizations.of(context)!.error}: ${snapshot.error}',
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(AppLocalizations.of(context)!.no_categories),
              );
            }

            final categories = snapshot.data!;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.01),
              child: Wrap(
                spacing: width * 0.01,
                runSpacing: height * 0.02,
                children: categories.map((category) {
                  final isSelected = _selectedCategoryId == category.id;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedCategoryId = category.id;
                      });
                      widget.onCategorySelected(
                          category.name,
                          category.id,
                          category.image
                      );
                      debugPrint('Selected Category: ${category.name}');
                      debugPrint('Selected Category ID: ${category.id}');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? (themeProvider.currentTheme == ThemeMode.light
                            ? AppColors.whiteColor
                            : AppColors.darkBlueColor)
                            : AppColors.transparentColor,
                      ),
                      child: Text(
                        category.name.split(' ').map((str) => str.isNotEmpty
                            ? str[0].toUpperCase() + str.substring(1).toLowerCase()
                            : '').join(' '),
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}