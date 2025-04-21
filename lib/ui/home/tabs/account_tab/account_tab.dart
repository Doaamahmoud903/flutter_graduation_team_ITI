import 'package:electro_app_team/providers/language_provider.dart';
import 'package:electro_app_team/ui/home/tabs/account_tab/privacy.dart';
import 'package:electro_app_team/ui/home/tabs/account_tab/profile.dart';
import 'package:electro_app_team/utils/app_assets.dart';
import 'package:electro_app_team/utils/app_styles.dart';
import 'package:electro_app_team/widgets/settings_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../providers/theme_provider.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/shared_perefrences.dart';
import '../../../../widgets/language_bottom_sheet.dart';
import '../../../../widgets/theme_bottom_sheet.dart';

class AccountTab extends StatefulWidget {
  static const String routeName = 'AccountTab';
  const AccountTab({super.key});

  @override
  State<AccountTab> createState() => _AccountTabState();
}

class _AccountTabState extends State<AccountTab> {
  int selectedIndex = 0;
  var width;
  var height;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    var themeProvider = Provider.of<ThemeProvider>(context);
    var languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              themeProvider.currentTheme == ThemeMode.light
                  ? languageProvider.currentLocal == "en"
                      ? AppAssets.mainLogo
                      : AppAssets.logoArDark
                  : languageProvider.currentLocal == "en"
                  ? AppAssets.mainLogoLight
                  : AppAssets.logoArLight,
              height: height * 0.09,
              width: 200,
            ),
            Padding(
              padding:
                  languageProvider.currentLocal == "en"
                      ? const EdgeInsets.only(left: 15)
                      : const EdgeInsets.only(right: 18),
              child: Text(
                AppLocalizations.of(context)!.welcome,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Padding(
              padding:
                  languageProvider.currentLocal == "en"
                      ? const EdgeInsets.only(left: 15)
                      : const EdgeInsets.only(right: 18),
              child: Text(
                'mohamed.N@gmail.com',
                style: TextStyle(
                  color: Theme.of(context).focusColor,
                  fontSize: 14,
                ),
              ),
            ),

            const SizedBox(height: 20),
            SettingsItem(
              title: AppLocalizations.of(context)!.profile,
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  ),
            ),
            Divider(
              indent: 20,
              endIndent: 20,
              thickness: 0.5,
              color:
                  themeProvider.currentTheme == ThemeMode.dark
                      ? Colors.white
                      : Colors.black,
            ),

            SettingsItem(
              title: AppLocalizations.of(context)!.privacy,
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PrivacyScreen(),
                    ),
                  ),
            ),
            Divider(
              indent: 20,
              endIndent: 20,
              thickness: 0.5,
              color:
                  themeProvider.currentTheme == ThemeMode.dark
                      ? Colors.white
                      : Colors.black,
            ),

            SettingsItem(
              title: AppLocalizations.of(context)!.language,
              trailingText:
                  languageProvider.currentLocal == "en" ? "English" : "العربيه",
              onTap: () => {showLanguageDropdownList(themeProvider)},
            ),
            Divider(
              indent: 20,
              endIndent: 20,
              thickness: 0.5,
              color:
                  themeProvider.currentTheme == ThemeMode.dark
                      ? Colors.white
                      : Colors.black,
            ),

            SettingsItem(
              title: AppLocalizations.of(context)!.theme,
              trailingText:
                  themeProvider.currentTheme == ThemeMode.light
                      ? (languageProvider.currentLocal == "en"
                          ? "Light"
                          : "فاتح")
                      : (languageProvider.currentLocal == "en"
                          ? "Dark"
                          : "داكن"),
              onTap: () => {showThemeDropdownList(themeProvider)},
            ),
            Divider(
              indent: 20,
              endIndent: 20,
              thickness: 0.5,
              color:
                  themeProvider.currentTheme == ThemeMode.dark
                      ? Colors.white
                      : Colors.black,
            ),

            SettingsItem(
              title: AppLocalizations.of(context)!.logout,
              onTap: () => {_showLogoutDialog(context, themeProvider)},
            ),
          ],
        ),
      ),
    );
  }

  void showLanguageDropdownList(themeProvider) {
    showModalBottomSheet(
      context: context,
      builder: (context) => LanguageBottomSheet(),
      backgroundColor:
          themeProvider.currentTheme == ThemeMode.light
              ? AppColors.whiteColor
              : AppColors.darkBlueColor,
    );
  }

  void showThemeDropdownList(themeProvider) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ThemeBottomSheet(),
      backgroundColor:
          themeProvider.currentTheme == ThemeMode.light
              ? AppColors.whiteColor
              : AppColors.darkBlueColor,
    );
  }

  void _showLogoutDialog(BuildContext context, themeProvider) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor:
                themeProvider.currentTheme == ThemeMode.light
                    ? AppColors.whiteColor
                    : AppColors.darkBlueColor,
            title: Text(AppLocalizations.of(context)!.logout),
            content: Text(AppLocalizations.of(context)!.logout_ques),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  AppLocalizations.of(context)!.cancel,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              TextButton(
                onPressed: () async {
                  final storageService = StorageService();
                  await storageService
                      .clearToken(); // delete token from SharedPreferences

                  //Navigate to login screen and delete all pervious screens
                  Navigator.of(
                    context,
                  ).pushNamedAndRemoveUntil('LoginScreen', (route) => false);
                },
                child: Text(
                  AppLocalizations.of(context)!.logout,
                  style: AppStyles.bold16Blue,
                ),
              ),
            ],
          ),
    );
  }
}
