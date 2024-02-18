import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:safeline_ku/common/util/common_color.dart';
import 'package:safeline_ku/home/controller/speech_to_text_controller.dart';

class HomeViewPage extends StatelessWidget {
  static const url = "/home";

  @override
  Widget build(BuildContext context) {
    final SpeechToTextController controller = Get.put(SpeechToTextController());

    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(12),
          children: [
            Obx(() {
              return IconButton(
                onPressed: controller.speechEnabled.value ? (controller.lastWords.isEmpty ? controller.startListening : controller.stopListening) : null,
                icon: controller.lastWords.isEmpty
                    ? SvgPicture.asset('assets/icon/voice_on.svg', width: 150, height: 150, color: ColorTheme.secondaryColor)
                    : SvgPicture.asset('assets/icon/voice_off.svg', width: 150, height: 150, color: ColorTheme.secondaryColor),
              );
              // FloatingActionButton.small(
              //     onPressed: controller.speechEnabled.value ? (controller.lastWords.isEmpty ? controller.startListening : controller.stopListening) : null,
              //     tooltip: 'Listen',
              //     backgroundColor: Colors.blueGrey,
              //     child: SvgPicture.asset(
              //       'assets/icon/voice_mic.svg',
              //       width: 88,
              //       height: 120,
              //     )
              //     //Icon(controller.lastWords.isEmpty ? Icons.mic : Icons.mic_off,color: Color,),
              //     );
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.textController,
                    minLines: 6,
                    maxLines: 10,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade300,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
