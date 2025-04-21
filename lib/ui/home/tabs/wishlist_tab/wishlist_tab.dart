import 'package:electro_app_team/widgets/main_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/language_provider.dart';
import '../../../../providers/theme_provider.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WishlistTab extends StatelessWidget {
  const WishlistTab({super.key});

  static const String routeName = "WishlistTab";

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    // Sample data to match your image
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

    return Scaffold(
      appBar: MainAppbar(width: width, height: height),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.01),
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.01),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 2, color: AppColors.primaryColor),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                // Image Section
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    AppAssets.carousel2,
                    width: 100,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: width * 0.03),

                // Details Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name and Favorite Icon
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            products[index]['name']!,
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: ImageIcon(
                              AssetImage(AppAssets.heartIcon),
                              color: themeProvider.currentTheme == ThemeMode.light
                                  ? AppColors.primaryColor
                                  : AppColors.whiteColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),

                      // category
                      Text(
                        products[index]['category']!,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      SizedBox(height: 12),

                      // Price and Add to Cart
                      Row(
                        children: [
                          Text(
                            products[index]['price']!,
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            height: 1,
                            width: 20,
                            color: AppColors.primaryColor,
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: themeProvider.currentTheme == ThemeMode.light
                                    ? AppColors.darkBlueColor
                                    : AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  // TODO: Add to cart
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.add_to_cart,
                                  style: const TextStyle(
                                    color: AppColors.whiteColor,
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );

        },
      ),
    );
  }
}