import 'package:electro_app_team/ui/auth/login_screen.dart';
import 'package:electro_app_team/ui/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../providers/language_provider.dart';
import '../../providers/theme_provider.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SplashPages extends StatefulWidget {
  const SplashPages({super.key});
  @override
  State<SplashPages> createState() => _SplashPagesState();
}

class _SplashPagesState extends State<SplashPages> {
  _SplashPagesState();
  final PageController _controller = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> splashPages = [
      {
        "img": AppAssets.splashIcon1,
        "title": AppLocalizations.of(context)!.splashP1Title,
        "body": AppLocalizations.of(context)!.splashP1Body,
      },
      {
        "img": AppAssets.splashIcon2,
        "title": AppLocalizations.of(context)!.splashP2Title,
        "body": AppLocalizations.of(context)!.splashP2Body,
      },
      {
        "img": AppAssets.splashIcon3,
        "title": AppLocalizations.of(context)!.splashP3Title,
        "body": AppLocalizations.of(context)!.splashP3Body,
      },
      {
        "img": AppAssets.splashIcon4,
        "title": AppLocalizations.of(context)!.splashP4Title,
        "body": AppLocalizations.of(context)!.splashP4Body,
      },
    ];

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    var languageProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        toolbarHeight: 100,
        centerTitle: true,
        title: SizedBox(height: 120, child: Image.asset(AppAssets.mainLogo)),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: splashPages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final page = splashPages[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        page["img"]!,
                        width: width * 0.9,
                        height: height * 0.4,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.07),
                      child: Text(
                        page["title"] ?? '',
                        textAlign: TextAlign.start,
                        style:
                            themeProvider.currentTheme == ThemeMode.light
                                ? Theme.of(context).textTheme.headlineLarge
                                    ?.copyWith(color: AppColors.blueColor)
                                : Theme.of(context).textTheme.headlineLarge
                                    ?.copyWith(color: AppColors.primaryColor),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.07),
                      child: Text(
                        page["body"] ?? '',
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.04,
              vertical: height * 0.02,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_currentIndex > 0)
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: IconButton(
                      icon: Image.asset(
                        languageProvider.currentLocal == "en"
                            ? AppAssets.backIcon
                            : AppAssets.nextIcon,
                        width: double.infinity,
                        height: 100,
                        fit: BoxFit.fill,
                        color: AppColors.blueColor,
                      ),
                      onPressed: () {
                        _controller.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                  ),
                Spacer(),
                Row(
                  children: List.generate(
                    splashPages.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 10,
                      ),
                      width: _currentIndex == index ? 12 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color:
                            _currentIndex == index
                                ? (themeProvider.currentTheme == ThemeMode.light
                                    ? AppColors.blackColor
                                    : AppColors.whiteColor)
                                : AppColors.blueColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: IconButton(
                    icon: Image.asset(
                      languageProvider.currentLocal == "en"
                          ? AppAssets.nextIcon
                          : AppAssets.backIcon,
                      width: double.infinity,
                      height: 100,
                      fit: BoxFit.fill,
                      color: AppColors.blueColor,
                    ),

                    onPressed: () => _goToNext(splashPages),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final token = prefs.getString('userToken');

    if (isLoggedIn && token != null) {
      // لو مسجل دخول
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    } else {
      // يروح لشاشة اللوجن
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    }
  }

  Future<void> _goToNext(List<Map<String, String>> splashPages) async {
    if (_currentIndex < splashPages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      final token = prefs.getString('userToken');
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);

      if (isLoggedIn && token != null) {
        // لو مسجل دخول
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      } else {
        // يروح لشاشة اللوجن
        Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
      }
    }
  }
}
