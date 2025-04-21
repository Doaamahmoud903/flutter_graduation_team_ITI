import 'dart:math';
import 'package:electro_app_team/models/product_model.dart';
import 'package:electro_app_team/services/product_service.dart';
import 'package:electro_app_team/utils/app_assets.dart';
import 'package:electro_app_team/widgets/carosuel_widget.dart';
import 'package:electro_app_team/widgets/home_carousal_item.dart';
import 'package:electro_app_team/widgets/main_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../providers/theme_provider.dart';
import '../../../../services/category_service.dart';
import '../../../../widgets/categort_item.dart';
import 'package:dio/dio.dart';
import 'package:electro_app_team/models/category_model.dart';

class HomeTab extends StatefulWidget {
  final VoidCallback? onViewAllTap;
  const HomeTab({super.key, this.onViewAllTap});

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late final CategoryService categoryService;
  late Future<List<CategoryModel>> categoriesFuture;
  late final ProductService productService;
  late Future<List<ProductModel>> productsFuture;


  @override
  void initState() {
    super.initState();
    categoryService = CategoryService(dio: Dio());
    categoriesFuture = fetchCategories();

    productService = ProductService(dio: Dio());
    productsFuture = getFetchedProducts(); // Corrected this line
  }

  Future<List<CategoryModel>> fetchCategories() async {
    return await categoryService.getAllCategories();  // Make sure to return the fetched categories
  }
  Future<List<ProductModel>> getFetchedProducts() async {
    return await productService.getAllProducts();
  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: MainAppbar(width: width, height: height),
      body: SafeArea(
      child : SingleChildScrollView(
        child: Column(
          children: [
            CarouselWidget(
              items: [
                HomeCarousalItem(img: AppAssets.carousel2, right: 0, left: 40),
                HomeCarousalItem(img: AppAssets.carousel1, right: 40, left: 0),
                HomeCarousalItem(img: AppAssets.carousel3, right: 0, left: 40),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width*0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.categories,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      widget.onViewAllTap?.call();
                    },
                    child:  Text(
                      AppLocalizations.of(context)!.view_all,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),

                ],
              ),
            ),
            SizedBox(height: height*0.01),
            FutureBuilder<List<CategoryModel>>(
              future: categoriesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text(AppLocalizations.of(context)!.error);
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text(AppLocalizations.of(context)!.no_categories);
                } else {
                  final categories = snapshot.data!;
                  return SizedBox(
                    height: height*0.24,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,  // Two columns each colum has 4 items
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                        childAspectRatio: 0.8,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: min(categories.length, 12),
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return CategoryItem(
                          title: category.name,
                          image: category.image,
                        );
                      },
                    ),
                  );
                }
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width*0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.feature_products,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      widget.onViewAllTap?.call();
                    },
                    child:  Text(
                      AppLocalizations.of(context)!.view_all,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: height*0.01),
            FutureBuilder<List<ProductModel>>(
              future: productsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text(AppLocalizations.of(context)!.error);
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text(AppLocalizations.of(context)!.no_products);
                } else {
                  final products  = snapshot.data!;
                  return SizedBox(
                    height: height*0.1,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                        childAspectRatio: 1,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: min(products.length, 4),
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return CategoryItem(
                          title: product.title,
                          image: product.image,
                          isCircle: false,
                        );
                      },
                    ),
                  );
                }
              },
            ),

          ],
        ),
      ),)
    );
  }
}
