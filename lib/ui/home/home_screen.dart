import 'package:electro_app_team/ui/home/tabs/account_tab/account_tab.dart';
import 'package:electro_app_team/ui/home/tabs/categories_tab/categories_tab.dart';
import 'package:electro_app_team/ui/home/tabs/home_tab/home_tab.dart';
import 'package:electro_app_team/ui/home/tabs/products_tab/products_tab.dart';
import 'package:electro_app_team/ui/home/tabs/wishlist_tab/wishlist_tab.dart';
import 'package:electro_app_team/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/language_provider.dart';
import '../../providers/theme_provider.dart';
import '../../utils/app_assets.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override


  int selectedIndex = 0;
  var width;
  var height;
  final List<String> imgList = [
      AppAssets.carousel1,
      AppAssets.carousel2,
      AppAssets.carousel3,
  ];


  @override
  Widget build(BuildContext context) {

    final List<Widget> tabs = [
      HomeTab(onViewAllTap: () {
        setState(() {
          selectedIndex = 2;
        });
      }),
      ProductsTab(),
      CategoriesTab(),
      WishlistTab(),
      AccountTab(),
    ];
    var languageProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    width = MediaQuery.of(context).size.width;
     height = MediaQuery.of(context).size.height;

    return Scaffold(

        body: tabs[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedIndex,
            onTap: (index){
              selectedIndex = index;
              setState(() {
                 selectedIndex = index;
              });
            },
            items: [
              buildBottomNavbarItems(
                  iconName: AppAssets.homeIcon,
                  index: 0,
                label: "Home"
              ),
              buildBottomNavbarItems(
                  iconName: AppAssets.productIcon,
                  index: 1,
                  label: "Products"
                  ),
              buildBottomNavbarItems(
                  iconName: AppAssets.categoryIcon,
                  index: 2,
                  label: "Categories"
                  ),
              buildBottomNavbarItems(
                  iconName: AppAssets.heartIcon,
                  index: 3,
                  label: "Wishlist"
                ),
              buildBottomNavbarItems(
                iconName: AppAssets.profileIcon,
                index: 4,
                  label: "Profile"
              )


            ])
    );
  }

  BottomNavigationBarItem buildBottomNavbarItems(
      {required int index  ,required String iconName , required String label}){
    return BottomNavigationBarItem(
        icon: selectedIndex == index ?
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: width*0.02,
              vertical: height*0.01,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(66),
            ),
            child: ImageIcon(AssetImage(iconName),
            color: AppColors.darkBlueColor,),
          ):ImageIcon(AssetImage(iconName),
        ),
      label: "",
           );
  }
}
