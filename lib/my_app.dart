import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'presentation/controllers/splash_screen_controller.dart';
import 'presentation/pages/splash_screen.dart';
import 'utils/constants/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Store Keeper App',
      theme: AppTheme.theme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => SplashScreen(),
          binding: BindingsBuilder(() {
            Get.put(SplashScreenController());
          }),
        ),
      ],
    );
  }
}
