import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:safeline_ku/common/util/common_color.dart';
import 'package:safeline_ku/route.dart';
import 'package:safeline_ku/splash/view/splash_view_page.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  //final mapKey = dotenv.env['MAPS_API_KEY'];

  runApp(GetMaterialApp(
    home: SplashViewPage(),
    theme: ThemeData(
      primaryColor: ColorTheme.primaryColor,
    ),
    debugShowCheckedModeBanner: false,
    getPages: GetXRouter.route,
  ));
}
