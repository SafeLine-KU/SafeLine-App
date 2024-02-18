import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safeline_ku/common/util/common_color.dart';

class HomeViewPage extends StatelessWidget {
  static const url = "/home";
  const HomeViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: ColorTheme.backgroundColor,
        body: FractionallySizedBox(
          heightFactor: 2 / 3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('안녕하세요'),
                  IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        'assets/icon/voice_mic.svg',
                        width: 80,
                      ))
                ],
              ),
            ],
          ),
        ));
  }
}
