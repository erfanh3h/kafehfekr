import 'package:kafehfekr/Core/Resources/app_theme.dart';
import 'package:kafehfekr/Core/Routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:refreshed/refreshed.dart';

import 'Core/Global/Pages/splash.dart';
import 'Core/Resources/app_translates.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await HiveComponent().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => GetMaterialApp(
        title: '10Fact',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
          Locale("en", "US"),
        ],
        locale: const Locale("fa", "IR"), //
        getPages: AppPages.pages,
        home: const SplashPage(),
        themeMode: ThemeMode.light,
        translations: AppTranslations(),
        defaultTransition: Transition.fadeIn,
      ),
    );
  }
}
