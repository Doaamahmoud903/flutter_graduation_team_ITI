import 'package:dio/dio.dart';
import 'package:electro_app_team/cubits/categories/category_cubit.dart';
import 'package:electro_app_team/cubits/products/products_cubit.dart';
import 'package:electro_app_team/providers/language_provider.dart';
import 'package:electro_app_team/providers/theme_provider.dart';
import 'package:electro_app_team/services/login_service.dart';
import 'package:electro_app_team/services/register_service.dart';
import 'package:electro_app_team/ui/auth/forget_password_screen.dart';
import 'package:electro_app_team/ui/auth/login_screen.dart';
import 'package:electro_app_team/ui/auth/register_screen.dart';
import 'package:electro_app_team/ui/auth/reset_password.dart';
import 'package:electro_app_team/ui/cart/cart_screen.dart';
import 'package:electro_app_team/ui/home/home_screen.dart';
import 'package:electro_app_team/ui/home/tabs/categories_tab/categories_tab.dart';
import 'package:electro_app_team/ui/onboarding/splash_screen.dart';
import 'package:electro_app_team/utils/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'cubits/cart/cart_cubit.dart';
import 'cubits/login/login_cubit.dart';
import 'cubits/register/register_cubit.dart';
import 'cubits/reset_password/reset_password_cubit.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
      ],

      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LoginCubit(loginService: LoginService(dio: Dio()))),
          BlocProvider(create: (context) => RegisterCubit(RegisterService(dio: Dio()))),
          BlocProvider(create: (context) => CategoryCubit()),
          BlocProvider(create: (context) => ProductsCubit()),
          BlocProvider(create: (_) => CartCubit()),
          BlocProvider<ResetPasswordCubit>(
           create: (context) => ResetPasswordCubit(),
           ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      themeMode: themeProvider.currentTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        LoginScreen.routeName:
            (context) => BlocProvider(
              create: (_) => LoginCubit(loginService: LoginService(dio: Dio())),
              child: const LoginScreen(),
            ),
        HomeScreen.routeName: (context) => HomeScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        ForgetPasswordScreen.routeName: (context) => ForgetPasswordScreen(),
        ResetPasswordScreen.routeName: (context) => ResetPasswordScreen(),
        SplashScreen.routeName: (context) => SplashScreen(),
        CategoriesTab.routeName: (context) => CategoriesTab(),
        CartScreen.routeName: (context) => CartScreen(),
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(languageProvider.currentLocal),
    );
  }
}
