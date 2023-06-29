
import 'package:flutter/material.dart';
import 'package:urine/model/urine_model.dart';
import 'package:urine/page/chart_page.dart';
import 'package:urine/utils/etc.dart';
import 'package:urine/utils/frame.dart';
import 'package:urine/widgets.dart';

import '../model/recent.dart';
import '../utils/color.dart';
import '../utils/constants.dart';
import '../utils/dio_client.dart';
import '../widgets/bottom_sheet.dart';

/// 최근 검사 내역 화면
class RecentPage extends StatefulWidget {
  final String title;
  final String datetime;

  RecentPage({required this.title, this.datetime = ''});

  @override
  State<RecentPage> createState() => _RecentPageState();
}

class _RecentPageState extends State<RecentPage> {

  late List<Recent> resultList = [];
  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: Frame.myAppbar(
        widget.title
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: client.dioRecent(widget.datetime),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

          if(snapshot.hasError){
            return Container(
                child: Center(
                    child: Text(snapshot.error.toString().replaceAll('Exception: ', ''),
                        textScaleFactor: 1.0, style: TextStyle(color: Colors.black))));
          }

          if (!snapshot.hasData) {
            return Container(
                child: Center(
                    child: SizedBox(height: 40.0, width: 40.0,
                        child: CircularProgressIndicator(strokeWidth: 5))));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            resultList = snapshot.data;
            // UrineModel urineModel = UrineModel();
            // urineModel.initOfList(resultList);
            //
            // /// 바텀샷 결과 페이지 보여주기
            // _showResult(urineModel);
          }


          return resultList.isEmpty ? EmptyView(text: '최근에 측정된 데이터가 없습니다.',) : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMeasurementTime(),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: ListView.builder(
                    itemCount: inspectionItemList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return RecentListItem(index: index, recentList: resultList);
                    },),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  _showResult(UrineModel urineModel) {
    /// 결과 데이터 view
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(
              builder: (BuildContext context, Function(void Function()) sheetSetState) {
                return FastestBottomSheet(urineModel: urineModel, size: size);
              });}
    );
  }

  _buildMeasurementTime() {
    return Container(
      height: 40,
      margin: const EdgeInsets.fromLTRB(20, 20, 30, 0),
      decoration: BoxDecoration(
        color: guideBackGroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Frame.myText(
            text: '측정 시간 : ' + Etc.setResultDateTime(resultList[0].datetime),
            fontWeight: FontWeight.w600,
            maxLinesCount: 1,
            fontSize: 1.0,
            align: TextAlign.center),
      ),
    );
  }
}

class RecentListItem extends StatelessWidget {

  final int index;
  final List<Recent> recentList;

  const RecentListItem({Key? key, required this.index, required this.recentList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        // Frame.doPagePush(context, ChartPage(
        //     dataType: recentList[index].dataType,
        //     itemName: Etc.dataTypeToItemName(recentList[index].dataType)));
      },
      child: Container(
        height: 60,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// 항목
                  Container(
                      width: 80,
                      child: Frame.myText(
                          text: inspectionItemList[index],
                          fontWeight: FontWeight.w600,
                          maxLinesCount: 1)
                  ),

                  /// 결과 Text
                  Frame.myText(text: recentList[index].result, fontWeight: FontWeight.w400, maxLinesCount: 1),

                  /// 결과 Image
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Image.asset(_resultStatusToImageStr(recentList[index].status), height: 60, width: 90),
                  )
                ]
      ),
          )
      )),
    );
  }

  _resultStatusToImageStr(String status){
    switch(status){
      case '0' : return 'images/step_0.png';
      case '1' : return 'images/step_1.png';
      case '2' : return 'images/step_2.png';
      case '3' : return 'images/step_3.png';
      case '4' : return 'images/step_4.png';
      case '5' : return 'images/step_4.png';
      default : return 'images/step_0.png';
    }
  }
}

class ResultListItem extends StatelessWidget {
  final int index;
  final String selectedInspectionType;
  final List<String>? fastestResult;
  final Function(int) changeItem;

  const ResultListItem({Key? key,
    required this.index,
    required this.fastestResult,
    required this.selectedInspectionType,
    required this.changeItem
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        changeItem(index);
        // Frame.doPagePush(context, ChartPage(
        //     dataType: fastestResult[index].dataType,
        //     itemName: Etc.dataTypeToItemName(fastestResult[index].dataType)));
      },
      child: Container(
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey,
                width: 0.5
              )
            )
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// 항목
                Container(
                    width: 90,
                    child: Frame.myText(
                        text: '${inspectionItemList[index] == selectedInspectionType ? '✓' : ''} ${inspectionItemList[index]}',
                        fontSize: inspectionItemList[index] == selectedInspectionType ? 1.2 : 1.1,
                        fontWeight: inspectionItemList[index] == selectedInspectionType ? FontWeight.w600 : FontWeight.normal,
                        color: inspectionItemList[index] == selectedInspectionType ? mainColor : Colors.black,
                        maxLinesCount: 1)
                ),

                /// 결과 Image
                Image.asset(
                    Etc.resultStatusToImageStr(fastestResult!, index),
                    height: 90,
                    width: 170
                ),

                /// 결과 Text
                Frame.myText(
                    text: Etc.resultStatusToText(fastestResult!, index),
                    fontWeight: inspectionItemList[index] == selectedInspectionType ? FontWeight.w600: FontWeight.w400,
                    color: Etc.resultStatusToTextColor(fastestResult!, index),
                    maxLinesCount: 1
                ),
              ]
          )),
    );
  }



}
