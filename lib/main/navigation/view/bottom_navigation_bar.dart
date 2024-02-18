import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:safeline_ku/common/util/common_color.dart';
import 'package:safeline_ku/main/navigation/controller/bottom_navigation_controller.dart';

class BottomNavgationWidget extends StatelessWidget {
  const BottomNavgationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    BottomNavgationBarController controller = Get.find<BottomNavgationBarController>();
    return MediaQuery.of(context).viewInsets.bottom == 0
        ? Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            width: double.infinity,
            // padding: EdgeInsets.only(bottom: Platform.isAndroid ? 12 : 0),
            child: Obx(() => Container(
                  decoration: const BoxDecoration(
                    color: ColorTheme.white,
                    border: Border(
                      top: BorderSide(
                        color: ColorTheme.grey_E8E8E8, // border의 색상
                        width: 1, // border의 두께
                      ),
                    ),
                  ),
                  child: BottomNavigationBar(
                    currentIndex: controller.selectedIndex.value,
                    onTap: (index) {
                      controller.changeIndex(index);
                    },
                    selectedItemColor: ColorTheme.iconActiveColor,
                    unselectedItemColor: ColorTheme.iconInActiveColor,
                    elevation: 0,
                    unselectedLabelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
                    selectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: ColorTheme.white,
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                          icon: Padding(
                            padding: const EdgeInsets.only(bottom: 0, top: 4),
                            child: ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                  controller.selectedIndex.value == 0 ? ColorTheme.iconActiveColor : ColorTheme.iconInActiveColor, BlendMode.srcATop),
                              child: controller.selectedIndex.value == 0
                                  ? SvgPicture.asset('assets/icon/navbar/map_on.svg')
                                  : SvgPicture.asset('assets/icon/navbar/map_off.svg'),
                            ),
                          ),
                          label: "Map"),
                      BottomNavigationBarItem(
                          icon: Padding(
                            padding: const EdgeInsets.only(bottom: 0, top: 4),
                            child: ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                  controller.selectedIndex.value == 1 ? ColorTheme.iconActiveColor : ColorTheme.iconInActiveColor, BlendMode.srcATop),
                              child: controller.selectedIndex.value == 1
                                  ? SvgPicture.asset('assets/icon/navbar/home_on.svg')
                                  : SvgPicture.asset('assets/icon/navbar/home_off.svg'),
                            ),
                          ),
                          label: "Home"),
                      BottomNavigationBarItem(
                          icon: Padding(
                            padding: const EdgeInsets.only(bottom: 0, top: 4),
                            child: ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                  controller.selectedIndex.value == 2 ? ColorTheme.iconActiveColor : ColorTheme.iconInActiveColor, BlendMode.srcATop),
                              child: controller.selectedIndex.value == 2
                                  ? SvgPicture.asset('assets/icon/navbar/edu_on.svg')
                                  : SvgPicture.asset('assets/icon/navbar/edu_off.svg'),
                            ),
                          ),
                          label: "Education"),
                    ],
                  ),
                )),
          )
        : const SizedBox();
  }
}
