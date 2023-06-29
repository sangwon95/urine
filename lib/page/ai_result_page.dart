
import 'package:flutter/material.dart';
import 'package:urine/model/authorization.dart';
import 'package:urine/utils/frame.dart';
import 'package:urine/widgets.dart';

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
  int resultPoint = 6;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    String str = widget.result.toString();
    List<String> parts = str.split(',');
    String mainResult = parts[0];

    if(mainResult == '만성신장질환'){
      resultPoint = 0;
    } else if(mainResult == '방광염'){
      resultPoint = 1;
    }else if(mainResult == '췌장염'){
      resultPoint = 2;
    }else if(mainResult == '빈혈'){
      resultPoint = 3;
    }else if(mainResult == '당뇨'){
      resultPoint = 4;
    }else if(mainResult == '신장염'){
      resultPoint = 5;
    } else {
      resultPoint = 6;
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
      backgroundColor: Colors.white,

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

  _buildAIResultText(String text) {
    return Container(
      height: 40,
      width: 380,
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
                text: '성분 분석 결과 ',
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
                text: text.contains('건강검진') ? '이 필요합니다.' : '관련성분이 검출 되었습니다.',
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
