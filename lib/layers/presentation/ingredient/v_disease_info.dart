
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:urine/common/constant/app_dimensions.dart';
import 'package:urine/layers/presentation/ingredient/vm_disease_info.dart';
import 'package:urine/layers/presentation/widget/style_text.dart';
import 'package:urine/layers/presentation/widget/w_dotted_line.dart';
import 'package:urine/layers/presentation/widget/w_future_handler.dart';

import '../../../../../../common/constant/app_colors.dart';
import '../../../common/constant/app_constants.dart';
import '../../../main.dart';
import '../widget/frame_container.dart';
import '../widget/scaffold/frame_scaffold.dart';

class ExpandedItem {
  String expandedValue;
  String headerValue;
  bool isExpanded;

  ExpandedItem({required this.expandedValue, required this.headerValue, this.isExpanded = false});
}

/// 성분별 관련 질환 정보 화면
class DiseaseInfoView extends StatefulWidget {
  const DiseaseInfoView({super.key});

  @override
  State<DiseaseInfoView> createState() => _DiseaseInfoViewState();
}

class _DiseaseInfoViewState extends State<DiseaseInfoView> {

  String get title => '관련 질환';
  String get intro => '성분별 여러 질환 정보를 제공합니다.';

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
                    rowContents('잠혈', '잠혈, 급성신장염, 만성신장염, 빈혈, 요로감염 등'),
                    const DottedLine(mWidth: double.infinity),

                    rowContents('빌리루빈', '간염, 담석, 췌장염, 담도폐쇄 등'),
                    const DottedLine(mWidth: double.infinity),

                    rowContents('유로빌리노겐', '급성간염, 만성 간염, 담관폐쇄, 변비 등'),
                    const DottedLine(mWidth: double.infinity),

                    rowContents('케톤체', '급성신장염, 만성신장염, 빈혈, 요로감염 등'),
                    const DottedLine(mWidth: double.infinity),

                    rowContents('단백질', '신장질환(사구체신염, 신우신염), 심부전(심장기능상실) 등'),
                    const DottedLine(mWidth: double.infinity),

                    rowContents('아질산염', '방광염, 신우신염'),
                    const DottedLine(mWidth: double.infinity),

                    rowContents('포도당', '당뇨, 췌장염, 갑상선항진증 등'),
                    const DottedLine(mWidth: double.infinity),

                    rowContents('PH', '산성 : 콩팥결핵, 중증당뇨증, 신장염, 알콜중독 등 염기성 : 요로감염증, 결석증, 과호흡 등'),
                    const DottedLine(mWidth: double.infinity),

                    rowContents('비중', '저비중 : 신부전, 신우신염\n고비중 : 당뇨병, 탈수증, 설사 등'),
                    const DottedLine(mWidth: double.infinity),

                    rowContents('백혈구', '신우신염, 방광염, 요로결석, 신장결핵 등'),
                    const DottedLine(mWidth: double.infinity),

                    rowContents('비타민', '비타민C 과잉의경우 요당, 단백질, 알칼리요등이 측정오류가 발생 할 수 있습니다.'),

                  ],
                )
            ),
          ),
        ),
      ),
    );
  }

  Widget rowContents(String title, String content) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 30,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: StyleText(
                  text: title,
                  fontWeight: AppDim.weightBold,
                  size: AppDim.fontSizeLarge,
                  maxLinesCount: 2,
                  softWrap: true,
                ),
              ),
              const Gap(10),

              Expanded(
                flex: 7,
                child: StyleText(
                  text: content,
                  fontWeight: AppDim.weight500,
                  color: AppColors.greyTextColor,
                  size: AppDim.fontSizeLarge,
                  maxLinesCount: 5,
                  height: 1.2,
                  softWrap: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}




