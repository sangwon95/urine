
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
    /// 수집된 수면데이터 [chartSleepData] 초기화

  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
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
                          inactiveBgColor: Colors.white,
                          activeBgColor: [mainColor],
                          customWidths: [width/4 -11, width/4 -11, width/4 -11, width/4 -11,],
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
                                    break; // 1주일

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
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                    child: Container(
                      height: 350,
                      width:  width - 45 + addWidth,
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
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
                                    }
                                    else{
                                      addWidth = 0;
                                    }
                                    if(chartListData.isEmpty){
                                      CustomDialog.showMyDialog('차트 조회', '검색 하신 데이터가 없습니다.', context, false);
                                    }
                                  });
                                });
                              }
                            }
                            return  ListView(
                              children: [
                                SizedBox(
                                  height: 300,
                                  width: width - 45 + addWidth,
                                  child: BarChart().buildColumnSeriesChart(chartData: chartData),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, top: 10, bottom: 50),
                child: Frame.myText(
                    text: '✓ 데이터가 많을 시 좌우로 스크롤이 가능합니다.',
                    fontSize: 0.9,
                    align: TextAlign.start,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.w600),
              ),


              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                child: Container(
                  height: 750,
                  width: width-40,
                  child: widget.dataType == 'DT11'? ViewVitamin(width: width) : FutureBuilder(
                    future: client.dioPrediction(widget.dataType),
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

                      if(snapshot.connectionState == ConnectionState.done){
                        predictionModel = snapshot.data;
                      }

                      return  Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children:
                          [
                            Container(
                              child: Row(
                                children: [
                                  Icon(Icons.feed_outlined),
                                  SizedBox(width: 10),
                                  Frame.myText(
                                    text: '건강예찰',
                                    fontSize: 1.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                            ),
                            buildColumn(width, predictionModel.name, predictionModel.symptoms),
                            buildColumn(width, '예상 질병', predictionModel.symptoms),
                            buildColumn(width, '예상 증상', predictionModel.disease),
                            buildColumn(width, '식이요법', predictionModel.food),
                            buildColumn(width, '운동 가이드', predictionModel.exercise),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              )
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


}
