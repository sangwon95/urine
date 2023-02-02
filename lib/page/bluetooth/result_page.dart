
import 'package:flutter/material.dart';
import 'package:urine/page/recent_page.dart';

import '../../model/urine_model.dart';
import '../../utils/color.dart';
import '../../utils/frame.dart';
import '../../widgets.dart';
import 'package:intl/intl.dart';

class ResultPage extends StatelessWidget {
  final UrineModel? urineModel;
  const ResultPage({Key? key, this.urineModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return urineModel == null ? Column(
      children: [
        EmptyView(text: '검사 결과를 가져오지 못했습니다.\n 다시 시도 바랍니다.',),
        /// 버튼 추가 필요!!!
      ],
    )
        :
    Container(
      height: 550,
      child: Container(
        padding: EdgeInsets.only(left: 0, right: 0, top: 15),
        child: ListView(
          children:
          [
            _buildViewText(),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildMeasurementTime(),
              ],

            ),
            Container(
              height: 700,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: urineModel?.urineList.length,
                itemBuilder: (BuildContext context, int index) {
                  return FastestResultListItem(index: index, fastestResult: urineModel?.urineList);
                },),
            ),
          ],
        ),
      ),
    );
  }
  _buildMeasurementTime() {
    return Container(
      height: 35,
      margin: const EdgeInsets.fromLTRB(30, 0, 0, 10),
      decoration: BoxDecoration(
        color: guideBackGroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Frame.myText(
            text: '측정 시간 : ' + DateFormat('yy년 MM월 dd일 HH시 mm분 ss초').format(DateTime.now()),
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w600,
            maxLinesCount: 1,
            fontSize: 0.8,
            align: TextAlign.center),
      ),
    );
  }
  _buildViewText() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 30, 20 ,10),
      child: Container(
        height: 50,
        child: Frame.myText(
            text: '✓ 유린기 측정 결과가 나왔습니다.',
            color: mainColor,
            fontWeight: FontWeight.w600,
            maxLinesCount: 1,
            fontSize: 1.4,
            align: TextAlign.center),
      ),
    );
  }
}
