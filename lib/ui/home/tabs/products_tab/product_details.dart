import 'package:electro_app_team/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:electro_app_team/models/product_model.dart';
import 'package:electro_app_team/utils/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../../providers/theme_provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.title
              .split(' ')
              .where((word) => word.isNotEmpty)
              .take(4)
              .map((str) => str[0].toUpperCase() + str.substring(1).toLowerCase())
              .join(' '),
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color:themeProvider.currentTheme == ThemeMode.light?
          AppColors.darkBlueColor
              :AppColors.whiteColor,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            icon:  Icon(
              Icons.search_rounded,
              color:themeProvider.currentTheme == ThemeMode.light?
              AppColors.darkBlueColor
                  :AppColors.whiteColor,
              size: 25,
            ),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ImageIcon(
              AssetImage(AppAssets.cartIcon),
              color:themeProvider.currentTheme == ThemeMode.light?
              AppColors.darkBlueColor
                  :AppColors.whiteColor,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.primaryColor, width: 2),
                ),
                child: Stack(
                  clipBehavior: Clip.none, // مهم عشان يسمح بخروج العناصر من الـ Stack
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        product.image,
                        height: height * 0.3,
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const Positioned(
                      top: 4,
                      right: 4,
                      child: Icon(Icons.favorite_border, color: Colors.white),
                    ),
                    Positioned(
                      bottom: -10,
                      left: 1,
                      right: 1,
                      child: Container(
                        padding:  EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: themeProvider.currentTheme == ThemeMode.light?
                          AppColors.whiteColor
                          :AppColors.darkBlueColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                product.title
                                    .split(' ')
                                    .where((word) => word.isNotEmpty)
                                    .take(2)
                                    .map((str) => str[0].toUpperCase() + str.substring(1).toLowerCase())
                                    .join(' ')
                                ,
                                style: theme.textTheme.headlineMedium
                            ),
                            Row(
                              children: [
                                const SizedBox(width: 4),
                                Text(
                                  'EGP ${product.price}',
                                  style: theme.textTheme.headlineLarge,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "3,230 Sold",
                    style: theme.textTheme.headlineMedium
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 20),
                    const SizedBox(width: 4),
                    Text(
                      '${product.rateAvg} (7,500)',
                      style: theme.textTheme.headlineLarge,
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color:themeProvider.currentTheme == ThemeMode.light?
                    AppColors.darkBlueColor
                        :AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(25)
                  ),
                  child: Row(
                    children: [
                      IconButton(onPressed: (){},
                          icon: ImageIcon(AssetImage(AppAssets.plusIcon),color:AppColors.whiteColor,)),
                      Text("1",
                        style: TextStyle(
                          color:AppColors.whiteColor,
                          fontSize: 18,
                        ),),
                      IconButton(onPressed: (){},
                          icon: ImageIcon(AssetImage(AppAssets.minusIcon),color:AppColors.whiteColor,)),

                    ],
                  ),
                )
              ],
            ),

            const SizedBox(height: 16),

            Text(
              "Description",
                style: theme.textTheme.headlineMedium
            ),
            const SizedBox(height: 8),

            Text(
              product.description,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 24),

            // Text("Available Colors", style: theme.textTheme.titleMedium),
            // const SizedBox(height: 8),
            // Row(
            //   children: [
            //     _colorOption(Colors.red),
            //     _colorOption(Colors.green),
            //     _colorOption(Colors.blue),
            //     _colorOption(Colors.orange),
            //   ],
            // ),
            // const SizedBox(height: 24),
            //
            // Text("Available Sizes", style: theme.textTheme.titleMedium),
            // const SizedBox(height: 8),
            // Row(
            //   children: [
            //     _sizeOption("S"),
            //     _sizeOption("M"),
            //     _sizeOption("L"),
            //     _sizeOption("XL"),
            //   ],
            // ),
            // const SizedBox(height: 32),

            Row(
              children: [
                Column(
                  children: [
                    Text(
                        "Total Price",
                        style: theme.textTheme.headlineMedium
                    ),Text(
                        'EGP ${product.price}',
                        style: theme.textTheme.headlineMedium
                    ),
                  ],

                ),
                Spacer(),
                SizedBox(
                  width: width*0.5,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor:themeProvider.currentTheme == ThemeMode.light?
                      AppColors.blueColor
                          :AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {},
                    icon:  Icon(Icons.shopping_cart ,  color:AppColors.whiteColor,),
                    label:  Text(
                      "Add to Cart",
                      style: TextStyle(fontSize: 18,
                        color:AppColors.whiteColor,),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _colorOption(Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
    );
  }

  Widget _sizeOption(String size) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Text(size),
    );
  }
}
