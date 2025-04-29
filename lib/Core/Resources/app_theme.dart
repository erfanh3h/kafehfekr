import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kafehfekr/Core/Resources/app_colors.dart';
import 'package:kafehfekr/Core/Resources/app_consts.dart';
import 'package:refreshed/refreshed.dart';

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
      unselectedItemColor: AppColors.primaryLight.withValues(alpha: .5),
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
    cardTheme: CardTheme(color: AppColors.primaryLight.withValues(alpha: .5)),
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: Colors.white70,
      hintStyle: TextStyle(color: Colors.black54),
    ),
    primaryColor: AppColors.primaryLight,
    fontFamily: FontFamilies.vazir,
    useMaterial3: true,
    dialogTheme: const DialogThemeData(backgroundColor: AppColors.secondary),
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
      unselectedItemColor: AppColors.primaryDark.withValues(alpha: .5),
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
    cardTheme: CardTheme(color: AppColors.primaryDark.withValues(alpha: .5)),
    primaryColor: AppColors.primaryDark,
    fontFamily: FontFamilies.vazir,
    useMaterial3: true,
    dialogTheme: const DialogThemeData(backgroundColor: AppColors.primaryDark),
  );
}

final headerGradient = LinearGradient(
  colors: [
    AppColors.darkRed,
    AppColors.darkRed.withValues(alpha: .6),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

LinearGradient makeGradient(Color firstColor, Color secondColor) =>
    LinearGradient(
      colors: [
        firstColor,
        secondColor.withValues(alpha: .6),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

final backButton = IconButton(
  onPressed: Get.back,
  icon: const Icon(
    CupertinoIcons.right_chevron,
    size: 30,
    color: AppColors.lightColor,
  ),
);
