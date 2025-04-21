import 'package:electro_app_team/ui/cart/cart_screen.dart';
import 'package:electro_app_team/widgets/search_results_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../../utils/app_assets.dart';
import '../cubits/products/products_cubit.dart';

class MainAppbar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final double width;
  final bool showCartIcon;
  final bool removePadding;

  MainAppbar({super.key, 
    required this.width,
    required this.height,
    this.showCartIcon = true,
    this.removePadding = false,
  });

  final TextEditingController _searchController = TextEditingController();

  @override
  Size get preferredSize => Size.fromHeight(150);

  void _onSearchSubmitted(BuildContext context) {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      context.read<ProductsCubit>().fetchProductsWithSearch(query);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SearchResultsScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);

    return AppBar(
      toolbarHeight: 150,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // logo
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                themeProvider.currentTheme == ThemeMode.light
                    ? AppAssets.mainLogo
                    : AppAssets.mainLogoLight,
                height: 55,
              ),
            ],
          ),
          // search bar
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: removePadding ? 0 : width * 0.03,
                vertical: height * 0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 300,
                  height: 50,
                  child: TextField(
                    controller: _searchController,
                    onSubmitted: (_) => _onSearchSubmitted(context),
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.searchHint,
                      hintStyle: Theme.of(context).textTheme.headlineSmall,
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () => _onSearchSubmitted(context),
                      ),
                      isCollapsed: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                showCartIcon
                    ? InkWell(
                  onTap: (){
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                      child: ImageIcon(
                                        AssetImage(AppAssets.cartIcon),
                                        color: Theme.of(context).primaryColor,
                                      ),
                    )
                    : const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

