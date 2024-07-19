import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryLight,
      surface: AppColors.backgroundLight,
    ),
    appBarTheme: const AppBarTheme(
      color: AppColors.primaryLight,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.backgroundLight,
      elevation: 10,
      selectedItemColor: AppColors.primaryLight,
      unselectedItemColor: AppColors.primaryLight.withOpacity(.5),
      selectedLabelStyle: const TextStyle(fontSize: 10),
      unselectedLabelStyle: const TextStyle(fontSize: 10),
    ),
    textTheme: TextTheme(
      displaySmall: TextStyle(
        color: Colors.white70,
        fontSize: 10.r,
        height: 1.1,
      ),
      displayLarge: TextStyle(
        color: Colors.white70,
        fontSize: 20.r,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryLight,
    ),
    cardTheme: CardTheme(color: AppColors.primaryLight.withOpacity(.5)),
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: Colors.white70,
      hintStyle: TextStyle(color: Colors.black54),
    ),
    dialogBackgroundColor: AppColors.secondary,
    primaryColor: AppColors.primaryLight,
    fontFamily: 'vazir',
    useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryDark,
      surface: AppColors.backgroundDark,
    ),
    appBarTheme: const AppBarTheme(
      color: AppColors.primaryDark,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.backgroundDark,
      elevation: 10,
      selectedItemColor: AppColors.primaryDark,
      unselectedItemColor: AppColors.primaryDark.withOpacity(.5),
      selectedLabelStyle: const TextStyle(fontSize: 10),
      unselectedLabelStyle: const TextStyle(fontSize: 10),
    ),
    textTheme: TextTheme(
      displaySmall: TextStyle(
        color: AppColors.fontLight,
        fontSize: 10.r,
        height: 1.1,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryDark,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: Colors.white70,
      hintStyle: TextStyle(color: Colors.white),
    ),
    dialogBackgroundColor: AppColors.primaryDark,
    cardTheme: CardTheme(color: AppColors.primaryDark.withOpacity(.5)),
    primaryColor: AppColors.primaryDark,
    fontFamily: 'vazir',
    useMaterial3: true,
  );
}
