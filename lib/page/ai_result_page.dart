
import 'package:flutter/material.dart';
import 'package:urine/model/authorization.dart';
import 'package:urine/utils/frame.dart';

import '../model/ai_result_data.dart';
import '../utils/color.dart';
import '../utils/constants.dart';
import '../utils/etc.dart';

class AIResultPage extends StatefulWidget {
  const AIResultPage({Key? key, required this.result}) : super(key: key);

  final String result;

  @override
  State<AIResultPage> createState() => _AIResultPageState();
}


class _AIResultPageState extends State<AIResultPage> {

  List<AIResultData> aiResultDataList = [];
  int resultPoint = 5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.result.contains('만성신장질환')){
      resultPoint = 0;
    } else if(widget.result.contains('방광염')){
      resultPoint = 1;
    }else if(widget.result.contains('췌장염')){
      resultPoint = 2;
    }else if(widget.result.contains('빈혈')){
      resultPoint = 3;
    }else if(widget.result.contains('당뇨')){
      resultPoint = 4;
    } else {
      resultPoint = 5;
    }

    aiResultDataList.add(
        AIResultData(
            '예상 증상', AIResult[resultPoint][0], AIResult[resultPoint][1]),
    );

    aiResultDataList.add(
      AIResultData(
          '예상 질병', AIResult[resultPoint][2], AIResult[resultPoint][3]),
    );

    aiResultDataList.add(
      AIResultData(
          '식이요법', AIResult[resultPoint][4], AIResult[resultPoint][5]),
    );
    aiResultDataList.add(
      AIResultData(
          '운동 가이드', AIResult[resultPoint][6], AIResult[resultPoint][7]),
    );
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: Frame.myAppbar(
        'AI 분석 결과'
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, 20, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Frame.myText (
                            text: '${Authorization().name}님',
                            fontSize: 1.6,
                            color: mainColor,
                            fontWeight: FontWeight.w600,
                          ),
                          Frame.myText(
                            text: ' 결과 데이터 기반으로 ',
                            fontSize: 1.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),

                      Frame.myText(
                        text: 'AI 분석 결과입니다.',
                        fontSize: 1.5,
                        align: TextAlign.start,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  )
              ),

              _buildAIResultText(widget.result),

              buildResultBox(aiResultDataList[0], stepAI1),
              buildResultBox(aiResultDataList[1], stepAI2),
              buildResultBox(aiResultDataList[2], stepAI3),
              buildResultBox(aiResultDataList[3], stepAI4),
            ],
          ),
        ),
      ),
      );
  }

   buildResultBox(AIResultData aiResultData,Color topTextColor) {
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                          color: topTextColor,
                        ),
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Center(
                          child: Frame.myText(
                              text: aiResultData.title,
                              fontSize: 1.2,
                              maxLinesCount: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              align: TextAlign.start),
                        ),
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
                      fontWeight: FontWeight.w500,
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
  //'방광염의 식이요법은 기본적으로 자극적인 음식과 음료를 피하는 것이 중요합니다. 특히 다음과 같은 식품을 제한하는 것이 좋습니다.\n\n'+
  //
  //                             '• 커피, 차, 탄산음료 등 자극적인 음료\n'+
  //                             '• 알코올, 담배 등의 유해물질\n'+
  //                             '• 매운 음식, 청량고추, 간장, 소금 등 자극적인 조미료\n'+
  //                             '• 반면 다음과 같은 식품을 적극적으로 섭취하는 것이 좋습니다.\n\n'+
  //
  //                             '• 물, 천연 주스, 녹차 등의 무자극적인 음료\n'+
  //                             '• 신선한 채소와 과일 등의 식이섬유가 풍부한 식품\n'+
  //                             '• 우유, 요구르트 등의 유산류\n'+
  //                             '• 식초, 오이, 김치 등의 식품\n\n'+
  //                            '운동적인 측면에서는 근력 운동과 요가가 방광염 치료에 도움이 된다는 연구 결과가 있습니다. 하지만 증상이 심한 경우에는 휴식이 필요할 수 있으며, 전문의의 지시에 따라 치료를 받아야 합니다.\n',


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
                text: '귀하는 현재 ',
                fontWeight: FontWeight.normal,
                maxLinesCount: 1,
                fontSize: 0.9,
                align: TextAlign.center),
            Frame.myText(
                text: ' "$text" ',
                fontWeight: FontWeight.w600,
                color: mainColor,
                maxLinesCount: 1,
                fontSize: 1.0,
                align: TextAlign.center),
            Frame.myText(
                text: text.contains('건강검진') ? '이 필요합니다.' : '으로 의심됩니다',
                fontWeight: FontWeight.normal,
                maxLinesCount: 2,
                fontSize: 0.9,
                align: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
