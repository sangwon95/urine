
import 'package:flutter/material.dart';
import 'package:urine/common/constant/app_dimensions.dart';
import 'package:urine/layers/presentation/widget/frame_container.dart';
import 'package:urine/layers/presentation/widget/style_text.dart';
import 'package:urine/layers/presentation/widget/w_dotted_line.dart';

import '../../../../../../common/constant/app_colors.dart';
import '../widget/scaffold/frame_scaffold.dart';

/// 비타민 영향력 내용 화면
class VitaminInfoView extends StatefulWidget {
  const VitaminInfoView({super.key});

  @override
  State<VitaminInfoView> createState() => _VitaminInfoViewState();
}

class _VitaminInfoViewState extends State<VitaminInfoView> {

  String get title => '성분분석';

  @override
  Widget build(BuildContext context) {
    return FrameScaffold(
      appBarTitle: title,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppDim.medium),
          child: FrameContainer(
            backgroundColor: AppColors.greyBoxBg,
            borderColor: AppColors.brightGrey,
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  rowContents('잠혈', '급성신장염, 만성신장염, 빈혈, 요로감염 등'),
                  rowContents('빌리루빈', '간염, 담석, 췌장염, 담도폐쇄 등'),
                  rowContents('우로빌리노겐', '급성간염, 만성 간염, 담관폐쇄, 변비 등'),
                  rowContents('케톤체', '급성신장염, 만성신장염, 빈혈, 요로감염 등'),
                  rowContents('단백질', '신장질환(사구체신염, 신우신염), 심부전(심장기능상실) 등'),
                  rowContents('아질산염', '방광염, 신우신염'),
                  rowContents('포도당', '당뇨, 췌장염, 갑상선항진증 등'),
                  rowContents('PH', '산성 : 콩팥결핵, 중증당뇨증, 신장염, 알콜중독 등 염기성 : 요로감염증, 결석증, 과호흡 등'),
                  rowContents('PH', '산성 : 콩팥결핵, 중증당뇨증, 신장염, 알콜중독 등\n염기성 : 요로감염증, 결석증, 과호흡 등'),
                  rowContents('비중', '저비중 : 신부전, 신우신염\n고비중 : 당뇨병, 탈수증, 설사 등'),
                  rowContents('비타민', '비타민C 결핍여부(성분 위음성 측정 관련 참고)'),
                ],
              )
            ),
          ),
        ),
      ),
    );
  }

  Widget rowContents(String title, String content) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: StyleText(
                text: title,
                fontWeight: AppDim.weightBold,
              ),
            ),
            Expanded(
              flex: 7,
              child: StyleText(
                text: content,
                fontWeight: AppDim.weight500,
                color: AppColors.greyTextColor,
                maxLinesCount: 4,
                softWrap: true,
              ),
            ),
          ],
        ),

        const DottedLine(mWidth: double.infinity)
      ],
    );
  }
}
