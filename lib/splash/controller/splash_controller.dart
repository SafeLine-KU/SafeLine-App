import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  @override
  void onReady() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.offAllNamed('/main');
    super.onReady();
  }
}
