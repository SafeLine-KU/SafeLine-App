import 'package:get/get.dart';
import 'package:safeline_ku/splash/view/splash_view_page.dart';

class GetXRouter {
  static final route = [
    GetPage(name: SplashViewPage.url, page: () => const SplashViewPage()),
  ];
}
