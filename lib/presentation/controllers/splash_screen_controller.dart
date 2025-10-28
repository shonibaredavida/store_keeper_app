import 'package:get/get.dart';

import '../pages/home_screen.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    Future.delayed(Duration(seconds: 3), () => Get.to(() => HomeScreen()));
    super.onInit();
  }
}
