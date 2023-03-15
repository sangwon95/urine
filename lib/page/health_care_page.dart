
import 'package:flutter/material.dart';
import 'package:urine/utils/color.dart';

import '../utils/frame.dart';
import 'chart_page.dart';

class HealthCarePage extends StatelessWidget {
  const HealthCarePage({Key? key}) : super(key: key);
  final String title = '나의 건강 관리';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Frame.myAppbar(
        title,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/innovation.png', height: 150, width: 150),
              SizedBox(height: 30),
              Frame.myText(
                text: '서비스 준비 중입니다.\n 결과 추이를 확인해보시겠습니까?',
                maxLinesCount: 2,
                align: TextAlign.center,
                fontWeight: FontWeight.bold,
                fontSize: 1.3
              ),
              SizedBox(height: 40),
              TextButton(
                style: TextButton.styleFrom(
                    primary: mainColor,
                  backgroundColor: mainColor,
                ),
                onPressed: () {
                  Frame.doPagePush(context, ChartPage());
                },
                child: SizedBox(
                  width: 180,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Frame.myText(
                          text: '추이 확인하러 가기',
                          color: Colors.white
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.arrow_forward_ios_sharp, color: Colors.white, size: 20)
                    ],
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
