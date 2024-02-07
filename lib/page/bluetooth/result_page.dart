
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:urine/page/recent_page.dart';

import '../../model/authorization.dart';
import '../../model/chart.dart';
import '../../model/recent.dart';
import '../../model/urine_model.dart';
import '../../utils/color.dart';
import '../../utils/constants.dart';
import '../../utils/dio_client.dart';
import '../../utils/etc.dart';
import '../../utils/frame.dart';
import '../../widgets.dart';
import 'package:intl/intl.dart';

import '../../widgets/dialog.dart';
import '../../widgets/line_chart.dart';

class ResultPage extends StatefulWidget {
  final UrineModel? urineModel;

  const ResultPage({Key? key, this.urineModel}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {

  late List<ChartData> chartData = [];
  late List<Recent> chartListData = [];

  late String searchStartDate = Etc.setDateDuration(0);
  late String searchEndDate = Etc.setDateDuration(0);

  /// 검사 타입 DT01 ~ DT11으로 11종 으로 구성되어 있다.
  late String inspectionType;
  late String inspectionItem;
  bool isScreenUpdate = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ///
    /// searchStartData, searchEndDate 날짜 초기 해야됨
    ///

    inspectionType = inspectionItemTypeList[0]; //DT01: 잠혈로 초기화
    inspectionItem =  inspectionItemList[0]; // 잠혈 Text
    _setSearchDate(180);
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return widget.urineModel == null ? Column(
      children: [
        EmptyView(text: '검사 결과를 가져오지 못했습니다.\n 다시 시도 바랍니다.',),
        /// 버튼 추가 필요!!!
      ],
    )
        :
    Container(
      height: size.height- 180,
      child: Container(
        padding: EdgeInsets.only(left: 0, right: 0, top: 15),
        child: ListView(
          children:
          [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                children: [

                  Column(
                    children:
                    [
                      _buildViewText(),
                    ],
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: FutureBuilder(
                        future: client.dioChartData(searchStartDate, searchEndDate),
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

                          if (snapshot.hasError) {
                            return Container(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(snapshot.error.toString().replaceAll('Exception: ', ''),
                                          textScaleFactor: 1.0, style: TextStyle(color: Colors.black)),
                                    ],
                                  ),
                                ));
                          }

                          if (!snapshot.hasData) {
                            return Container(
                                child: Center(
                                    child: SizedBox(height: 40.0, width: 40.0,
                                        child: CircularProgressIndicator(strokeWidth: 5))));
                          }

                          if (snapshot.connectionState == ConnectionState.done) {

                            if(isScreenUpdate) {
                              isScreenUpdate = false;
                              chartListData.clear();
                              chartData.clear();

                              chartListData = snapshot.data;

                              for (var value in chartListData) {
                                if (value.dataType == inspectionType) // 타입구분자로 원하는 차트를 구성할 수 있다.
                                    {
                                  if (!chartData.any((element) => element.x.toString().contains(Etc.setGroupDateTime(value.datetime)))) {
                                    if(chartData.length < 5){
                                      chartData.add(ChartData(x: Etc.setGroupDateTime(value.datetime), y: int.parse(value.status)));
                                    }
                                  }
                                }
                              }

                              Future.delayed(Duration(milliseconds: 100), () {
                                setState(() {
                                  if (chartListData.isEmpty) {
                                    CustomDialog.showMyDialog(
                                        '차트 조회', '검색 하신 데이터가 없습니다.', context, false);
                                  }
                                });
                              });
                            }
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: 150,
                                  child: BarChart().buildColumnSeriesMiniChart(chartData: chartData)
                              ),

                              Container(
                                      decoration: BoxDecoration(
                                        color: guideBackGroundColor,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Frame.myText(
                                            text: '$inspectionItem 추이',
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.w600,
                                            maxLinesCount: 1,
                                            fontSize: 0.8,
                                            align: TextAlign.start),
                                      ),
                                    )
                                  ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            _buildMeasurementTime(),

            Container(
              height: 700,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.urineModel?.urineList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ResultListItem(
                    index: index,
                    fastestResult: widget.urineModel?.urineList,
                    selectedInspectionType: inspectionItem,
                    changeItem: (int) => _changeItem(int),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildMeasurementTime() {
    return Container(
      height: 30,
      margin: const EdgeInsets.only(top: 0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Frame.myText(
            text: '✓ 측정 시간: '+DateFormat('yy년 MM월 dd일 HH시 mm분').format(DateTime.now()),
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w600,
            maxLinesCount: 1,
            fontSize: 0.8,
            align: TextAlign.start),
      ),
    );
  }

  _buildViewText() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0 ,10),
      child: Container(
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Frame.myText(
                text: '✓  ${Authorization().name}님',
                color: mainColor,
                fontWeight: FontWeight.w600,
                maxLinesCount: 4,
                fontSize: 1.3,
                align: TextAlign.start
            ),

            SizedBox(height: 5),

            Frame.myText(
                text: '11종 검사 결과 입니다.',
                fontWeight: FontWeight.w600,
                maxLinesCount: 2,
                fontSize: 1.1,
                align: TextAlign.start
            ),

            SizedBox(height: 20),

            Frame.myText(
                text: '아래의 항목들을 클릭 해보세요.(항목에 따라 그래프가 변화됩니다. 최근 5일 데이터 입니다.)',
                color: Colors.grey,
                fontWeight: FontWeight.w600,
                maxLinesCount: 4,
                fontSize: 0.85,
                align: TextAlign.start)
          ],
        ),
      ),
    );
  }

  _setSearchDate(int duration) {
    searchStartDate = Etc.setDateDuration(duration);
    searchEndDate   = Etc.setDateDuration(0);
  }

  _changeItem(int selectedIdx) {
    setState(() {
      inspectionType = inspectionItemTypeList[selectedIdx]; //DT01: 잠혈로 초기화
      inspectionItem =  inspectionItemList[selectedIdx]; // 잠혈 Text
      isScreenUpdate = true;
    });
  }
}
