import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/language_provider.dart';
import '../../providers/theme_provider.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../widgets/language_bottom_sheet.dart';
import '../../widgets/theme_bottom_sheet.dart';


class WelcomeScreen extends StatefulWidget {
  final VoidCallback onStart;
  const WelcomeScreen({super.key, required this.onStart});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build( BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var languageProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                AppAssets.splashMainIcon,
                height: height*0.5,
              ),
            ),
            SizedBox(height: height*0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width*0.04),
              child: Text(
                AppLocalizations.of(context)!.splashTitle,
                textAlign: TextAlign.start,
                style:  Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            SizedBox(height: height*0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width*0.04),
              child: Text(AppLocalizations.of(context)!.splashDescription,
                textAlign: TextAlign.start,
                style:  Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            SizedBox(height: height*0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width*0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context)!.language,
                    style:  Theme.of(context).textTheme.bodyLarge,

                  ),
                  GestureDetector(
                    onTap: () {
                      if (languageProvider.currentLocal == "en") {
                        languageProvider.changeLocal("ar");
                      } else {
                        languageProvider.changeLocal("en");
                      }
                    },
                    child: Image.asset(
                      AppAssets.langSwitch,
                      width: 74,
                    ),
                  ),
                ],
              ),
            ),SizedBox(height: height*0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width*0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.theme ,
                    style: Theme.of(context).textTheme.bodyLarge,

                  ),
                  InkWell(
                    onTap: () {
                      if (themeProvider.currentTheme == ThemeMode.light) {
                        themeProvider.changeTheme(ThemeMode.dark);
                      } else {
                        themeProvider.changeTheme(ThemeMode.light);
                      }
                      // showThemeDropdownList(themeProvider);

                    },
                    child: Image.asset(
                      AppAssets.themeSwitch,
                      width: 74,
                      height: 31,
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: height*0.04),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.onStart();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blueColor,
                    foregroundColor: Colors.black,
                    padding:  EdgeInsets.symmetric(vertical: height*0.02),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(AppLocalizations.of(context)!.splashBtn,
                      style: AppStyles.bold20white
                  ),
                ),
              ),
            ),
          ]
      ),
    );
  }

  void showLanguageDropdownList(){
    showModalBottomSheet(context: context,
        builder: (context)=> LanguageBottomSheet()
    );
  }
  void showThemeDropdownList(themeProvider) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ThemeBottomSheet(),
      backgroundColor: themeProvider.currentTheme == ThemeMode.light
          ? AppColors.whiteColor
          : AppColors.darkBlueColor,
    );
  }


}

