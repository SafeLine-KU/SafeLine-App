import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safeline_ku/common/util/common_color.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomeViewPage extends StatefulWidget {
  const HomeViewPage({Key? key}) : super(key: key);

  @override
  _HomeViewPage createState() => _HomeViewPage();
}

class _HomeViewPage extends State<HomeViewPage> {
  final TextEditingController _textController = TextEditingController();

  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = "";

  void listenForPermissions() async {
    final status = await Permission.microphone.status;
    switch (status) {
      case PermissionStatus.denied:
        requestForPermission();
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
    }
  }

  Future<void> requestForPermission() async {
    await Permission.microphone.request();
  }

  @override
  void initState() {
    super.initState();
    listenForPermissions();
    if (!_speechEnabled) {
      _initSpeech();
    }
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
  }

  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      listenFor: const Duration(seconds: 30),
      localeId: "ko-KR",
      cancelOnError: false,
      partialResults: false,
      listenMode: ListenMode.confirmation,
    );
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = "$_lastWords${result.recognizedWords} ";
      _textController.text = _lastWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image/background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(12),
          children: [
            Stack(
              children: [
                // Positioned(
                //   left: 75,
                //   right: 75,
                //   child: Image.asset(
                //     'assets/image/circle.png',
                //     width: 225,
                //     height: 225,
                //   ),
                // ),
                Column(
                  children: [
                    Text(
                      'Click Icon',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: ColorTheme.primaryColor),
                    ),
                    IconButton(
                      onPressed: _speechToText.isNotListening
                          ? _startListening
                          : _stopListening,
                      icon: AnimatedSwitcher(
                        duration: Duration(milliseconds: 1000), // 애니메이션 지속 시간
                        switchInCurve: Curves.easeIn, // 애니메이션 곡선 설정
                        switchOutCurve: Curves.easeOut,
                        transitionBuilder: (child, animation) {
                          return RotationTransition(
                            turns: animation, // 크기 조절 애니메이션
                            child: child,
                          );
                        },
                        child: _speechToText.isNotListening
                            ? Image.asset(
                                'assets/image/voice_off.png',
                                key: UniqueKey(),
                                width: 200,
                                height: 200,
                              )
                            : Image.asset(
                                'assets/image/voice_on.png',
                                key: UniqueKey(),
                                width: 200,
                                height: 200,
                              ),
                      ),
                    ),
                    TextField(
                      controller: _textController,
                      minLines: 6,
                      maxLines: 10,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          hintText:
                              '\nstep1. 이름, 나이, 신체정보 등을 말해주세요.\nstep2. 현재 자신의 위치를 말해주세요.\nstep3. 주변 상황이 어떠한지 말해주세요.\nstep4. 안내사항에 따라 대처해주세요.',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade600,
                          )),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Requset',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: ColorTheme.white,
                        backgroundColor:
                            const Color.fromARGB(255, 238, 105, 107),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
