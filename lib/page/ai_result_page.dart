
import 'package:flutter/material.dart';
import 'package:urine/model/authorization.dart';
import 'package:urine/page/vitamin_info_page.dart';
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
        '성분 분석 결과'
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
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
                        text: '성분 분석 결과입니다.',
                        fontSize: 1.5,
                        align: TextAlign.start,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  )
              ),

              _buildAIResultText(widget.result),
              const SizedBox(height: 30),

              buildVitaminAdvice(),

              const SizedBox(height: 15),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Frame.myText(
                text: aiResultData.title,
                fontSize: 1.2,
                maxLinesCount: 30,
                color: mainColor,
                fontWeight: FontWeight.w600,
                align: TextAlign.start),
          ),
        const SizedBox(height: 10),

        Container(
          decoration: BoxDecoration(
            color: Color(0xFFecf4f6),
            borderRadius: BorderRadius.circular(10.0)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: Frame.myText(
                    text: aiResultData.mainText,
                    fontSize: 1.1,
                    maxLinesCount: 30,
                    fontWeight: FontWeight.w600,
                    align: TextAlign.start),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Frame.myText(
                    text:aiResultData.subMainText,
                    maxLinesCount: 30,
                    fontWeight: FontWeight.w500,
                    align: TextAlign.start),
              )
            ],
          ),
        )
        ],
      ),
    );
  }

  _buildAIResultText(String text) {
    return Container(
      decoration: BoxDecoration(
        color: guideBackGroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: MediaQuery(
                data: Etc.getScaleFontSize(context, fontSize: 1.2),
                child: RichText(
                  text:TextSpan(
                    text: '성분 분석 결과 ',
                    style: TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(text: ' "$text" ', style: TextStyle(fontWeight: FontWeight.bold, color: mainColor, fontSize: 15)),
                      TextSpan(text: text.contains('건강검진') ? '이 필요합니다.' : '관련성분이 검출 되었습니다'),
                    ],
                  ),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }

  /// 비타민 검출에 대한 조언 위젯
  buildVitaminAdvice(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Frame.myText(
                      text: 'Tip!',
                      fontSize: 1.2,
                      maxLinesCount: 30,
                      color: Colors.yellow.shade600,
                      fontWeight: FontWeight.w600,
                      align: TextAlign.start),

                  const SizedBox(width: 10),

                  Frame.myText(
                      text: '비타민 검출 영향',
                      fontSize: 1.0,
                      maxLinesCount: 30,
                      color: Colors.yellow.shade600,
                      fontWeight: FontWeight.w600,
                      align: TextAlign.start),
                ],
              ),

              InkWell(
                onTap: ()=> Frame.doPagePush(context, VitaminInfoPage()),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10,0,10,0),
                  child: Frame.myText(
                    text: '더보기',
                    color: Colors.grey,
                  ),
                ),
              )
            ],
          ),
        ),

        Container(
          decoration: BoxDecoration(
              color: Color(0xFFecf4f6),
              borderRadius: BorderRadius.circular(10.0)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(20, 15, 20, 10),
                child: Frame.myText(
                    text: '성분 분석 결과 대부분 음성이며, "소변 건강양호"로 분석 되었습니다.',
                    maxLinesCount: 30,
                    align: TextAlign.start),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: Frame.myText(
                    text: '과잉 비타민 C 는 일부 성분의 위음성에 영향을 줄 수 있으므로 해당 시 재검사를 권장합니다.',
                    maxLinesCount: 30,
                    color: Colors.red.shade300,
                    fontWeight: FontWeight.w500,
                    align: TextAlign.start),
              )
            ],
          ),
        )
      ],
    );
  }
}
