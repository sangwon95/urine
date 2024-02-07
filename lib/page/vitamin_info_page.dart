
import 'package:flutter/material.dart';
import 'package:urine/utils/etc.dart';
import 'package:urine/utils/frame.dart';

/// 비타민 상세 정보 화면
class VitaminInfoPage extends StatelessWidget {
  const VitaminInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Frame.myAppbar(
        '비타민 영향',
      ),
      body: buildContainer(context),
    );
  }

  buildContainer(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        height: 680,
        padding: EdgeInsets.all(20.0),
        margin: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color(0xFFecf4f6),
        ),
        child: Column(
          children: [
            _buildTableColumnItem('잠혈', '급성신장염, 만성신장염, 빈혈, 요로감염 등'),
            Etc.solidLineVitamin(context),
            _buildTableColumnItem('빌리루빈', '간염, 담석, 췌장염, 담도폐쇄 등'),
            Etc.solidLineVitamin(context),
            _buildTableColumnItem('우로빌리노겐', '급성간염, 만성 간염, 담관폐쇄, 변비 등'),
            Etc.solidLineVitamin(context),
            _buildTableColumnItem('케톤체', '췌장염, 갑상선항진증, 구토, 임신 등'),
            Etc.solidLineVitamin(context),
            _buildTableColumnItem('단백질', '신장질환(사구체신염, 신우신염), 심부전(심장기능상실)등'),
            Etc.solidLineVitamin(context),
            _buildTableColumnItem('아질산염', '방광염, 신우신염'),
            Etc.solidLineVitamin(context),
            _buildTableColumnItem('포도당', '당뇨, 췌장염, 갑상선항진증 등'),
            Etc.solidLineVitamin(context),
            _buildTableColumnItem(
                'PH', '산성: 콩팥결핵, 중증당뇨증, 신장염, 알콜중독 등\n염기성: 요로감염증, 결석증, 과호흡 등'),
            Etc.solidLineVitamin(context),
            _buildTableColumnItem('비중', '저비중: 신부전, 신우신염\n고비중: 당뇨병, 탈수증, 설사 등'),
            Etc.solidLineVitamin(context),
            _buildTableColumnItem('백혈구', '신우신염, 방광염, 요도결석, 신장결핵 등'),
            Etc.solidLineVitamin(context),
            _buildTableColumnItem('비타민', '비타민 C 결핍여부(성분 위음성 측정 관련 참고)'),
          ],
        ),
      ),
    );
  }

  _buildTableColumnItem(String title, String content) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 50
      ),
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: Frame.myText(
                text: title,
                fontSize: 1.2,
                maxLinesCount: 2,
                fontWeight: FontWeight.bold,
                align: TextAlign.start
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 8,
            child: Frame.myText(text: content, fontSize: 1.1, maxLinesCount: 5),
          )
        ],
      ),
    );
  }
}
