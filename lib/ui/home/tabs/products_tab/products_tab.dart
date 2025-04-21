import 'package:electro_app_team/cubits/products/products_cubit.dart';
import 'package:electro_app_team/cubits/products/products_state.dart';
import 'package:electro_app_team/models/product_model.dart';
import 'package:electro_app_team/ui/home/tabs/products_tab/product_details.dart';
import 'package:electro_app_team/utils/app_assets.dart';
import 'package:electro_app_team/utils/app_colors.dart';
import 'package:electro_app_team/widgets/main_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../../../providers/language_provider.dart';
import '../../../../providers/theme_provider.dart';

class ProductsTab extends StatelessWidget {
  const ProductsTab({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (_) => ProductsCubit()..getFetchedProducts(),
      child: Scaffold(
        appBar: MainAppbar(width: width, height: height),
        body: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductsFailure) {
              return Center(child: Text("Failed: ${state.error}"));
            } else if (state is ProductsLoaded) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  itemCount: state.products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.65,
                  ),
                  itemBuilder: (context, index) {
                    final product = state.products[index];
                 
                      return ProductCard(product: product);

                  },
                ),
              );
            } else {
              return const Center(child: Text("No products found."));
            }
          },
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductModel product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.primaryColor,
            width: 2
          )
        ),
        padding: EdgeInsets.symmetric(horizontal: width*0.02 , vertical: height*0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          product.image ?? "",
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const Positioned(
                        top: 4,
                        right: 4,
                        child: Icon(Icons.favorite_border, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
             SizedBox(height: height*0.01),
            Text(
              product.title.split(' ').map((str) => str.isNotEmpty
              ? str[0].toUpperCase() + str.substring(1).toLowerCase()
          : '').join(' ') ?? "No Name",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            // SizedBox(height: height*0.01),
            // Text(
            //   product.description ?? "No description",
            //   maxLines: 1,
            //   overflow: TextOverflow.ellipsis,
            //   style: TextStyle(color: AppColors.lightGrayColor, fontSize: 12),
            // ),
            SizedBox(height: height*0.01),
            Row(
              children: [
                Text(
                  'EGP ${product.price}',
                  style: TextStyle(
                    fontSize: 14,
                    color: themeProvider.currentTheme == ThemeMode.light
                      ? AppColors.blackColor
                        :AppColors.whiteColor
                  ),
                ),
                 SizedBox(width: width*0.02),
                if (product.priceAfterDiscount != null)
                  Text(
                    'EGP ${product.priceAfterDiscount}',
                    style:  TextStyle(
                      decoration: TextDecoration.lineThrough,
                        fontSize: 14,
                        color: themeProvider.currentTheme == ThemeMode.light
                            ? AppColors.primaryColor
                            :AppColors.darkBlueColor
                    ),
                  ),
              ],
            ),
            SizedBox(height: height*0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Row(
                children: [
                  Text(
                      'Review (${(double.tryParse(product.rateAvg?.toString() ?? '0') ?? 0).toStringAsFixed(1)})',
                      style: TextStyle(
                          color: themeProvider.currentTheme == ThemeMode.light
                              ? AppColors.blackColor
                              :AppColors.whiteColor
                          ,fontSize: 14
                      )
                  ),
                  ImageIcon(AssetImage(AppAssets.starIcon) , color: Color(0xFFFDD835),),
                ],
              ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: themeProvider.currentTheme == ThemeMode.light
                        ? AppColors.darkBlueColor
                        :AppColors.primaryColor,
                    shape: BoxShape.circle,

                  ),

                    child: IconButton(
                      icon: Icon(Icons.add,
                          color: themeProvider.currentTheme == ThemeMode.light
                          ? AppColors.whiteColor
                          :AppColors.darkBlueColor),
                      onPressed: () {
                      },
                    ),

                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
