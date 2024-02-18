import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeline_ku/home/view/home_view_page.dart';
import 'package:safeline_ku/main/navigation/controller/bottom_navigation_controller.dart';
import 'package:safeline_ku/main/navigation/view/bottom_navigation_bar.dart';

class MainViewPage extends StatelessWidget {
  static const url = "/main";
  const MainViewPage({super.key});

  static List<Widget> navBar = <Widget>[
    HomeViewPage(),
    HomeViewPage(),
    HomeViewPage(),
  ];

  @override
  Widget build(BuildContext context) {
    BottomNavgationBarController navController = Get.put(BottomNavgationBarController());

    return Scaffold(
      body: Obx(() => navBar[navController.selectedIndex.value]),
      bottomNavigationBar: const BottomNavgationWidget(),
    );
  }
}
