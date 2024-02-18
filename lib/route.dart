import 'package:get/get.dart';
import 'package:safeline_ku/home/view/home_view_page.dart';
import 'package:safeline_ku/main/view/main_view_page.dart';
import 'package:safeline_ku/splash/view/splash_view_page.dart';

class GetXRouter {
  static final route = [
    GetPage(name: SplashViewPage.url, page: () => const SplashViewPage()),
    GetPage(name: MainViewPage.url, page: () => const MainViewPage()),
    GetPage(name: HomeViewPage.url, page: () => const HomeViewPage()),
  ];
}
