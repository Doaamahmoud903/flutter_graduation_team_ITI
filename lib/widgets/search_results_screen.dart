import 'package:electro_app_team/cubits/products/products_state.dart';
import 'package:electro_app_team/widgets/main_appbar.dart';
import 'package:flutter/material.dart';
import 'package:electro_app_team/models/product_model.dart';
import 'package:electro_app_team/cubits/products/products_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../utils/app_colors.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: MainAppbar(
        width: width,
        height: height,
        showCartIcon: false,
        removePadding: true,
      ),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductsFailure) {
            return Center(child: Text(state.error));
          } else if (state is ProductsEmpty) {
            return Center(child: Text(AppLocalizations.of(context)!.no_products));
          } else if (state is ProductsLoaded) {
            return _buildProductList(state.products, themeProvider);
          }
          return const Center(child: Text("No products found."));
        },
      ),
    );
  }

  Widget _buildProductList(List<ProductModel> products, ThemeProvider themeProvider) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ListTile(
          leading: Image.network(product.image),
          title: Text(
            product.title.split(' ').map((str) => str.isNotEmpty
                ? str[0].toUpperCase() + str.substring(1).toLowerCase()
                : '').join(' '),
            style: TextStyle(
              color: themeProvider.currentTheme == ThemeMode.light
                  ? AppColors.blackColor
                  : AppColors.whiteColor,
            ),
          ),
          subtitle: Text(
            'EGP ${product.price}',
            style: TextStyle(
              color: themeProvider.currentTheme == ThemeMode.light
                  ? AppColors.blackColor
                  : AppColors.whiteColor,
            ),
          ),
          onTap: () {
            // Navigate to product details
          },
        );
      },
    );
  }
}
