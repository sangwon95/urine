
import 'package:flutter/material.dart';
import 'package:urine/main.dart';
import 'package:urine/model/ai_result_data.dart';
import 'package:urine/utils/frame.dart';

import '../utils/color.dart';
import '../utils/constants.dart';

/**
 * 나의 건강 관리
 */
class MyHealthPage extends StatefulWidget {
  const MyHealthPage({Key? key}) : super(key: key);

  @override
  State<MyHealthPage> createState() => _MyHealthPageState();
}

class _MyHealthPageState extends State<MyHealthPage> {
  final String title = '나의 건강 관리';
  int weekday = 1;
  List<AIResultData> aiResultDataList = [];

  String todayHealth = '만성신장질환';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var now = DateTime.now();
    weekday = now.weekday;


    if(weekday == 1){
      todayHealth = '만성신장질환';
    } else if(weekday == 2 ){
      todayHealth ='방광염';
    }else if(weekday == 3 || weekday == 7){
      todayHealth ='췌장염';
    }else if(weekday == 4){
      todayHealth ='빈혈';
    }else if(weekday == 5){
      todayHealth ='당뇨';
    }else if(weekday == 6){
      todayHealth ='신장염';
    }

    aiResultDataList.add(
      AIResultData(
          '식이요법', AIResult[weekday-1][4], AIResult[weekday-1][5]),
    );
    aiResultDataList.add(
      AIResultData(
          '운동 가이드', AIResult[weekday-1][6], AIResult[weekday-1][7]),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Frame.myAppbar(
        title
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAIResultText(todayHealth),

                buildResultBox(aiResultDataList[0], stepAI3),
                buildResultBox(aiResultDataList[1], stepAI4),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildAIResultText(String text) {
    return Container(
      height: 40,
      width: 330,
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      decoration: BoxDecoration(
        color: guideBackGroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Frame.myText(
                text: '오늘의 건강관리는',
                fontWeight: FontWeight.normal,
                maxLinesCount: 1,
                fontSize: 1.2,
                align: TextAlign.center),
            Frame.myText(
                text: ' ${text} 입니다.',
                fontWeight: FontWeight.w600,
                color: mainColor,
                maxLinesCount: 1,
                fontSize: 1.2,
                align: TextAlign.center),

          ],
        ),
      ),
    );
  }


  buildResultBox(AIResultData aiResultData, Color topTextColor) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25)),
                        color: topTextColor,
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          child: Image.asset(aiResultData.title == '식이요법' ? 'images/health_food.jpg' : 'images/exercise.jpg', fit: BoxFit.fill)),
                    ),
                  ),
                ],
              ),

              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Frame.myText(
                    text: aiResultData.mainText,
                    fontSize: 1.1,
                    maxLinesCount: 30,
                    fontWeight: FontWeight.w600,
                    align: TextAlign.start),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Frame.myText(
                    text:aiResultData.subMainText,
                    fontSize: 1.1,
                    maxLinesCount: 30,
                    fontWeight: FontWeight.w500,
                    align: TextAlign.start),
              )
            ],
          )
      ),
    );
  }
}
