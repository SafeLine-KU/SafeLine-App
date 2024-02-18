import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeline_ku/common/util/common_color.dart';
import 'package:safeline_ku/splash/controller/splash_controller.dart';

class SplashViewPage extends StatelessWidget {
  static const url = "/splash";
  const SplashViewPage({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());

    return Scaffold(
      backgroundColor: ColorTheme.primaryColor,
      body: FractionallySizedBox(
        heightFactor: 2 / 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/image/logo.png',
                  width: 141,
                  height: 141,
                ),
                SizedBox(height: 20),
                Text(
                  'SafeLine',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: ColorTheme.white,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
