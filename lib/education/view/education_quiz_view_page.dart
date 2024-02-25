import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safeline_ku/common/util/common_color.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:http/http.dart' as http;

class EducationQuizViewPage extends StatefulWidget {
  final String imageId;
  final String imageUrl;
  const EducationQuizViewPage(
      {super.key, required this.imageId, required this.imageUrl});

  @override
  State<EducationQuizViewPage> createState() => _EducationQuizViewPageState();
}

class _EducationQuizViewPageState extends State<EducationQuizViewPage> {
  final TextEditingController _textController = TextEditingController();

  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = "";
  String? _feedbackMessage; //퀴즈 정답 후 피드백

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

  void _refreshText() {
    setState(() {
      _lastWords = "";
      _textController.text = "";
    });
  }

  Future<void> _submitAnswer() async {
    final url =
        'https://d29cb15c-e309-44ed-9ea7-cb7577a0c6e5.mock.pstmn.io/instruction/assessment';
    final requestData = {
      "id": widget.imageId,
      "answer": _textController.text,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        setState(() {
          _feedbackMessage = responseData['assessment'];
        });

        _showFeedbackBottomSheet();
      } else {
        setState(() {
          _feedbackMessage = 'Failed to get feedback.';
        });
      }
    } catch (e) {
      setState(() {
        _feedbackMessage = 'Error: $e';
      });
    }
  }

  void _showFeedbackBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Text(
            'Feedback: $_feedbackMessage',
            style: TextStyle(fontSize: 18),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Page'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 30),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  widget.imageUrl,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      );
                    }
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    minLines: 6,
                    maxLines: 10,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(26, 255, 30, 0),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _refreshText();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorTheme.thirdColor, // 버튼의 배경색 설정
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(Icons.refresh, color: ColorTheme.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_speechToText.isNotListening) {
                          _startListening();
                        } else {
                          _stopListening();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorTheme.thirdColor, // 버튼의 배경색 설정
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(
                          _speechToText.isNotListening
                              ? Icons.mic_off
                              : Icons.mic,
                          color: ColorTheme.white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 50),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  _submitAnswer();
                },
                child: Text(
                  'Submit answer',
                  style: TextStyle(
                    fontSize: 25,
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
      ),
    );
  }
}
