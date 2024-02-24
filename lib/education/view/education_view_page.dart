import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeline_ku/education/controller/education_controller.dart';

class EducationViewPage extends StatelessWidget {
  static const url = "/education";
  const EducationViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    EducationController controller = Get.put(EducationController());

    return Obx(() => ListView.builder(
          itemCount: controller.instructions.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(controller.instructions[index]['instruction']),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(controller.instructions[index]['image']),
              ),
            );
          },
        ));
  }
}
