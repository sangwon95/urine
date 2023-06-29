
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:urine/main.dart';
import 'package:urine/model/prediction_model.dart';
import 'package:urine/utils/frame.dart';
import 'package:urine/widgets/dialog.dart';
import 'package:urine/widgets/line_chart.dart';

import 'package:intl/intl.dart';
import '../model/chart.dart';
import '../model/recent.dart';
import '../utils/color.dart';
import '../utils/dio_client.dart';
import '../utils/etc.dart';
import '../widgets.dart';
import '../widgets/button.dart';
import '../widgets/text_field.dart';

// ignore: must_be_immutable
class ChartPage extends StatefulWidget {
  String dataType;
  String itemName;

  ChartPage({this.dataType = 'DT01',  this.itemName = '잠혈'});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {

  late List<ChartData> chartData = [];
  late List<Recent> chartListData = [];
  late PredictionModel predictionModel;


  String startDateText = DateFormat('yyyy. MM. dd').format(DateTime.now());
  String endDateText   = DateFormat('yyyy. MM. dd').format(DateTime.now());

  late String searchStartDate = Etc.setDateDuration(0);
  late String searchEndDate = Etc.setDateDuration(0);

  int addWidth = 0;

  var initialLabelIndex = 0;

  bool isScreenUpdate = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Frame.myAppbar(
        '결과 내역 추이'
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children:
                [
                  Expanded(
                    flex: 1,
                      child: ItemNameDropdownButton(
                          itemName: widget.itemName,
                          onChanged: (newValue) => _dropdownJobNameValueChanged(newValue))),

                  SizedBox(width: 10),

                  /// 날짜 범위
                  DateTextField(
                      text: '$startDateText ~ $endDateText',
                      updateDateBirth: (searchStartDate, searchEndDate)=> _updateDate(searchStartDate, searchEndDate)),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  height: 35,
                  child: Row(
                    children: [
                      Expanded(
                        child: ToggleSwitch(
                          initialLabelIndex: initialLabelIndex,
                          totalSwitches: 4,
                          inactiveBgColor: Colors.grey.shade200,
                          activeBgColor: [mainColor],
                          customWidths: [size.width/4 -11, size.width/4 -11, size.width/4 -11, size.width/4 -11,],
                          labels: ['직접', '1주일', '1달', '6개월'],
                          fontSize: 13,
                          onToggle: (index) {
                            print('switched to: $index');
                            initialLabelIndex = index!;
                            setState(() {
                                switch(index){
                                  case 0:
                                    _setSearchDate(0); // 오늘
                                  break;

                                  case 1:
                                    _setSearchDate(7); // 1주일
                                    break;

                                  case 2:
                                    _setSearchDate(30); // 1달
                                    break;

                                  case 3:
                                    _setSearchDate(180); // 6개월
                                    break;
                                }
                              });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SearchButton(btnName: '검색', context: context, refresh: ()=>_refresh()),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  width: size.width - 45 + addWidth,
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 25, 25, 0),
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

                          if(isScreenUpdate){
                            isScreenUpdate = false;
                            chartListData.clear();
                            chartData.clear();
                            addWidth = 0;

                            chartListData = snapshot.data;

                            for(var value in chartListData)
                            {
                              if(value.dataType == widget.dataType)
                              {
                                if(!chartData.any((element)=> element.x.toString().contains(Etc.setGroupDateTime(value.datetime)))){
                                  chartData.add(ChartData(x: Etc.setGroupDateTime(value.datetime), y: int.parse(value.status)));
                                }
                              }
                            }

                            Future.delayed(Duration(milliseconds: 100), (){
                              setState((){
                                if(chartData.length > 4){
                                  addWidth = 50 * chartData.length;
                                } else {
                                  addWidth = 0;
                                }
                                if(chartListData.isEmpty){
                                  CustomDialog.showMyDialog('차트 조회', '검색 하신 데이터가 없습니다.', context, false);
                                }
                              });
                            });
                          }
                        }
                        return SizedBox(
                          height: (size.height * 0.5) -150,
                          width: size.width - 45 + addWidth,
                          child: BarChart().buildColumnSeriesChart(chartData: chartData),
                        );
                      },
                    ),
                  ),
                ),
              ),
              buildGuideBox(mainColor)

            ],
          ),
        ),
      )
    );
  }

  Column buildColumn(double width, String headText, String mainText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(top: 20),
          child: Frame.myText(
              text: '✓ $headText',
              color: mainColor,
              fontSize: 1.2,
              fontWeight: FontWeight.w600,
              align: TextAlign.start),
        ),
        Container(
          padding: EdgeInsets.only(left: 20, top: 10),
          width: width - 110,
          child: Frame.myText(text: mainText, maxLinesCount: 4),
        ),

        Etc.solidLineSetting(context),
      ],
    );
  }


  /// JobName Dropdown onChanged function
  _dropdownJobNameValueChanged(String? newValue){
    setState(() {
      widget.itemName = newValue!;
      widget.dataType = Etc.itemNameToDataType(widget.itemName);
    });
  }


  /// Date of Birth update method
  _updateDate(String searchStartDate, String searchEndDate){
    setState(() {

      this.searchStartDate = searchStartDate;
      this.searchEndDate   = searchEndDate;
      startDateText        = Etc.setSearchDateView(searchStartDate);
      endDateText          = Etc.setSearchDateView(searchEndDate);

      initialLabelIndex = 0;

      mLog.d('searchStartDate : $searchStartDate');
      mLog.d('searchEndDate : $searchEndDate');
      Navigator.pop(context);
    });
  }


  _refresh(){
    setState(() {
      isScreenUpdate = true;
    });
  }


  _setSearchDate(int duration) {
    searchStartDate = Etc.setDateDuration(duration);
    searchEndDate   = Etc.setDateDuration(0);
    startDateText   = Etc.setSearchDateView(searchStartDate);
    endDateText     = Etc.setSearchDateView(searchEndDate);
  }


  buildGuideBox(Color topTextColor) {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
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
                            text: '알아보기',
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
                    text: '• 결과 내역 추이를 통해서 자신의 건상상태 추이를 확인 할 수 있습니다.\n• 검사 항목은 총 11개 있습니다.\n'
                        '• 검색 기간을 수동, 1주, 1달, 6개월 간단하게 설정 할 수 있습니다.\n• 사용 그래프는 좌우로 스크롤이 가능합니다.\n',
                    fontSize: 1.1,
                    maxLinesCount: 30,
                    align: TextAlign.start),
              ),
            ],
          )
      ),
    );
  }
}
