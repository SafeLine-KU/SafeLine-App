import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextController extends GetxController {
  final SpeechToText _speechToText = SpeechToText();
  final TextEditingController textController = TextEditingController();
  RxBool speechEnabled = false.obs;
  String lastWords = "";

  @override
  void onInit() {
    super.onInit();
    listenForPermissions();
    _initSpeech();
  }

  void listenForPermissions() async {
    final status = await Permission.microphone.status;
    switch (status) {
      case PermissionStatus.denied:
        await requestForPermission();
        break;
      case PermissionStatus.granted:
        break;
      case PermissionStatus.limited:
        break;
      case PermissionStatus.permanentlyDenied:
        break;
      case PermissionStatus.restricted:
        break;
      case PermissionStatus.provisional:
        // TODO: Handle this case.
        break;
    }
  }

  Future<void> requestForPermission() async {
    await Permission.microphone.request();
  }

  Future<void> _initSpeech() async {
    speechEnabled.value = await _speechToText.initialize();
  }

  void startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      listenFor: const Duration(seconds: 30),
      localeId: "ko-KR",
      cancelOnError: false,
      partialResults: false,
      listenMode: ListenMode.confirmation,
    );
  }

  void stopListening() async {
    await _speechToText.stop();
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    lastWords += "${result.recognizedWords} ";
    textController.text = lastWords;
  }
}
