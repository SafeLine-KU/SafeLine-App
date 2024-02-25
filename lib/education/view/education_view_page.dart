import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:safeline_ku/common/util/common_color.dart';
import 'package:safeline_ku/education/controller/education_controller.dart';

class EducationViewPage extends StatelessWidget {
  static const url = "/education";
  const EducationViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    EducationController controller = Get.put(EducationController());

    return SafeArea(
      child: Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.fetchQuizzes('wildfire');
                    },
                    child: Text(
                      'Quiz Start',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: ColorTheme.white,
                      backgroundColor: const Color.fromARGB(255, 238, 105, 107),
                    ),
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
