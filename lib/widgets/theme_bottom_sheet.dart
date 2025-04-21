import 'package:electro_app_team/widgets/selected_bottom_item.dart';
import 'package:electro_app_team/widgets/unselected_bottom_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../providers/theme_provider.dart';
import '../utils/app_colors.dart';

class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      height: height*0.3,
     decoration: BoxDecoration(
       color:themeProvider.currentTheme == ThemeMode.light
           ? AppColors.whiteColor
           : AppColors.darkBlueColor,
       borderRadius: BorderRadius.only(topRight: Radius.circular(20) , topLeft: Radius.circular(20))
     ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              themeProvider.changeTheme(ThemeMode.light);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04, vertical: height * 0.02),
              child: themeProvider.currentTheme == ThemeMode.light
                  ? SelectedBottomItem(selectedItem: AppLocalizations.of(context)!.light)
                  : UnselectedBottomItem(selectedItem: AppLocalizations.of(context)!.light),
            ),
          ),
          InkWell(
            onTap: () {
              themeProvider.changeTheme(ThemeMode.dark);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04, vertical: height * 0.01),
              child: themeProvider.currentTheme == ThemeMode.dark
                  ? SelectedBottomItem(selectedItem: AppLocalizations.of(context)!.dark)
                  : UnselectedBottomItem(selectedItem: AppLocalizations.of(context)!.dark),
            ),
          ),
        ],
      ),
    );
  }
}
