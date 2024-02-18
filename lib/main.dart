import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeline_ku/common/util/common_color.dart';
import 'package:safeline_ku/route.dart';
import 'package:safeline_ku/splash/view/splash_view_page.dart';

void main() {
  runApp(GetMaterialApp(
    home: SplashViewPage(),
    theme: ThemeData(
      primaryColor: ColorTheme.primaryColor,
    ),
    debugShowCheckedModeBanner: false,
    getPages: GetXRouter.route,
  ));
}
