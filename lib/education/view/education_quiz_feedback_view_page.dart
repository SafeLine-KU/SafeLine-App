import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EducationQuizFeedbackViewPage extends StatelessWidget {
  final String? feedbackMessage;

  const EducationQuizFeedbackViewPage({Key? key, this.feedbackMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 150),
              SizedBox(
                height: 200,
                child: Image.asset(
                  'assets/image/good.png',
                  width: 200,
                  height: 200,
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: 300,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.grey[100], // 배경색 설정
                  borderRadius: BorderRadius.circular(15.0), // 모서리 설정
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // 그림자 색상 설정
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // 그림자 위치 설정
                    ),
                  ],
                ),
                child: Text(
                  '${feedbackMessage ?? ""}', // null 일 때를 대비하여 null 확인 및 처리
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
