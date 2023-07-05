import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quran/resources/constants.dart';
import 'package:quran/resources/init.dart';
import 'package:quran/splash/screen/splash_screen.dart';
import 'package:quran/resources/theme_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      statusBarColor: Colors.transparent));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{

  @override
  void initState() {
    super.initState();
    InitResources.initResources();
  }

  @override
  void dispose() {
    super.dispose();
    InitResources.disposeResources();
  }
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(442, 869),
        minTextAdapt: true,
        builder: (context, _) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            translations: LocalStings(),
            locale: const Locale('en', 'US'),
            title: 'Quran',
            theme: getAppTheme(),
            home: const SplashScreen(),
          );
        });
  }
}
