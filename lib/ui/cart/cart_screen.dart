import 'package:electro_app_team/utils/app_assets.dart';
import 'package:electro_app_team/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/language_provider.dart';
import '../../providers/theme_provider.dart';
class CartScreen extends StatelessWidget {
   CartScreen({super.key});
  static const String routeName = "CartScreen";

  final List<Map<String, String>> products = [
    {
      'name': 'Nike Air Jordon',
      'category': 'Laptops',
      'price': 'EGP 1,200',
    },
    {
      'name': 'Nike Air Jordon',
      'category': 'Laptops',
      'price': 'EGP 600',
    },
    {
      'name': 'Nike Air Jordon',
      'category': 'Laptops',
      'price': 'EGP 1,200',
    },
  ];
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Cart",style: Theme.of(context).textTheme.headlineLarge,),
            Spacer(),
            Row(
              children: [
                IconButton(onPressed: (){},
                    icon: ImageIcon(AssetImage(AppAssets.searchIcon),
                      color: themeProvider.currentTheme == ThemeMode.light
                    ?AppColors.darkBlueColor
                    :AppColors.whiteColor)),
                IconButton(onPressed: (){},
                    icon: ImageIcon(AssetImage(AppAssets.addToCart),
                        color: themeProvider.currentTheme == ThemeMode.light
                            ?AppColors.darkBlueColor
                            :AppColors.whiteColor)),
              ],
            )
          ],
        ),
      ),
      body:ListView.builder(
          padding:  EdgeInsets.symmetric(horizontal:width*0.02 , vertical: height*0.02 ),

          itemCount: products.length, // بدل 5
          itemBuilder: (BuildContext context, int index) {
            final product = products[index];

            return Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.01),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 2,
                  color: AppColors.primaryColor,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        AppAssets.carousel2,
                        width: 100,
                        height: 100,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(width: width * 0.02),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product['name'] ?? '',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Text(
                            product['category'] ?? '',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Text(
                            product['price'] ?? '',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: ImageIcon(
                          AssetImage(AppAssets.deleteIcon),
                          color: themeProvider.currentTheme == ThemeMode.light
                              ? AppColors.darkBlueColor
                              : AppColors.whiteColor,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: ImageIcon(
                              AssetImage(AppAssets.plusIcon),
                              color: themeProvider.currentTheme == ThemeMode.light
                                  ? AppColors.darkBlueColor
                                  : AppColors.whiteColor,
                            ),
                          ),
                          Text(
                            "1",
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 18,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: ImageIcon(
                              AssetImage(AppAssets.minusIcon),
                              color: themeProvider.currentTheme == ThemeMode.light
                                  ? AppColors.darkBlueColor
                                  : AppColors.whiteColor,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            );
          }

      ),
    );
  }
}
