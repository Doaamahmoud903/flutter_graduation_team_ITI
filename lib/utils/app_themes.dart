import 'package:electro_app_team/utils/app_colors.dart';
import 'package:electro_app_team/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AppTheme{
  static final ThemeData lightTheme = ThemeData(
      fontFamily: "IBMPlexMono",
      primaryColor: AppColors.blueColor,
      focusColor: AppColors.darkBlueColor,
      textTheme: TextTheme(
        headlineLarge: AppStyles.bold20Black,
        headlineMedium: AppStyles.semiBold18Black,
        headlineSmall: AppStyles.semiBold14Black,
        bodyLarge: AppStyles.bold24Blue,
        bodyMedium: AppStyles.semiBold16Black,
        displayMedium: AppStyles.bold16Blue,
        displayLarge: AppStyles.bold22black
      ),
      scaffoldBackgroundColor: AppColors.whiteColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.blueColor,
        selectedItemColor: AppColors.whiteColor,
        unselectedItemColor: AppColors.whiteColor,
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: AppColors.whiteColor,
          iconTheme: IconThemeData(
            color: AppColors.blackColor,
            size: 22
          )
      )
  );

  static final ThemeData darkTheme = ThemeData(
      textTheme: TextTheme(
        headlineLarge: AppStyles.bold20white,
        headlineSmall: AppStyles.semiBold14white,
        headlineMedium: AppStyles.semiBold18White,
        bodyLarge: AppStyles.bold20Blue,
          bodyMedium: AppStyles.bold16white,
          displayMedium: AppStyles.bold16white,
          displayLarge: AppStyles.bold22white

      ),
      fontFamily: "IBMPlexMono",
      primaryColor: AppColors.whiteColor,
      focusColor: AppColors.blueColor,
      scaffoldBackgroundColor: AppColors.darkBlueColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkBlueColor,
        selectedItemColor: AppColors.whiteColor,
        unselectedItemColor: AppColors.whiteColor,
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: AppColors.darkBlueColor,
          iconTheme: IconThemeData(
            color: AppColors.whiteColor,
            size: 22
          )
      )
  );
}