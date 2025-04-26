import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:kafehfekr/Core/Global/Components/sound_player.dart';
import 'package:kafehfekr/Core/Resources/app_theme.dart';
import 'package:kafehfekr/Core/Routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:refreshed/refreshed.dart';
import 'package:window_manager/window_manager.dart';

import 'Core/Global/Pages/splash.dart';
import 'Core/Resources/app_translates.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
  } else if (Platform.isWindows) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      size: Size(450, 900),
      center: true,
      skipTaskbar: false,
      minimumSize: Size(450, 900),
      maximumSize: Size(450, 900),
      windowButtonVisibility: false,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  } else if (Platform.isAndroid) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      try {
        Get.find<SoundPlayerComponent>().pauseMusic();
      } catch (_) {}
    } else if (state == AppLifecycleState.resumed) {
      Get.find<SoundPlayerComponent>().resumeMusic();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1)),
        child: GetMaterialApp(
          title: 'کافه فکر',
          debugShowCheckedModeBanner: false,
          popGesture: false,
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
      ),
    );
  }
}
