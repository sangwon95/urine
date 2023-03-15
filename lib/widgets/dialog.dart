import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:urine/utils/etc.dart';
import '../utils/color.dart';

class CustomDialog{
  /// convert 0-1 to 0-1-0

  static showMyDialog(String title, String text, BuildContext mainContext, bool isCancelBtn) {
    return showDialog(
        context: mainContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            title: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: mainColor, size: 35),
                  SizedBox(height: 10),
                  Text(title, textScaleFactor: 0.85, style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 190,
                      child: Text(text, textAlign: TextAlign.center, textScaleFactor: 0.85)),
                ],
              ),
            ),
            contentPadding:EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
            actionsAlignment: MainAxisAlignment.center,
            actions: <Widget>[
              Visibility(
                visible: isCancelBtn,
                child: Container(
                  width: 120,
                  height: 40,
                  margin: EdgeInsets.only(bottom: 10),
                  child: TextButton(
                      style: TextButton.styleFrom(
                          elevation: 3.0,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                             // side: BorderSide(width: 1.0, color: Colors.grey.shade100),
                              borderRadius: BorderRadius.circular(5.0))),
                      onPressed: ()
                      {
                        Navigator.pop(context);
                      },
                      child: Text('취소', textScaleFactor: 1.0, style: TextStyle(color: Colors.grey.shade600))
                  ),
                ),
              ),

              Container(
                height: 40,
                width: isCancelBtn ? 120 : 240,
                margin: EdgeInsets.only(bottom: 10),
                child: TextButton(
                    style: TextButton.styleFrom(
                        elevation: 5.0,
                        backgroundColor: mainColor,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1.0, color: mainColor),
                            borderRadius: BorderRadius.circular(5.0))),
                    onPressed: ()
                    {
                      Navigator.pop(context);
                    },
                    child: Text('확인', textScaleFactor: 1.0, style: TextStyle(color: Colors.white))
                ),
              ),

            ],
          );
        });
  }

  /// 네트워크 연결 상태 다이얼로그
  static showNetworkDialog(String title, String text, BuildContext mainContext, Function onPressed) {
    return showDialog(
        context: mainContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            title: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, textScaleFactor: 0.85, style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 190,
                      child: Text(text, textAlign: TextAlign.center, textScaleFactor: 0.85)),
                ],
              ),
            ),
            contentPadding:EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
            actionsAlignment: MainAxisAlignment.center,
            actions: <Widget>[
              Container(
                height: 40,
                width:  240,
                margin: EdgeInsets.only(bottom: 10),
                child: TextButton(
                    style: TextButton.styleFrom(
                        elevation: 5.0,
                        backgroundColor: mainColor,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1.0, color: mainColor),
                            borderRadius: BorderRadius.circular(5.0))),
                    onPressed: ()
                    {
                      onPressed();
                    },
                    child: Text('확인', textScaleFactor: 1.0, style: TextStyle(color: Colors.white))
                ),
              ),

            ],
          );
        });
  }

  /// 다이얼 로그
  static showActionDialog(String title, String text, BuildContext mainContext) {
    return showDialog(
        context: mainContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            title: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, textScaleFactor: 0.85, style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 190,
                      child: Text(text, textAlign: TextAlign.center, textScaleFactor: 0.85)),
                ],
              ),
            ),
            contentPadding:EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
            actionsAlignment: MainAxisAlignment.center,
            actions: <Widget>[
              Container(
                width: 120,
                height: 40,
                margin: EdgeInsets.only(bottom: 10),
                child: TextButton(
                    style: TextButton.styleFrom(
                        elevation: 3.0,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
                    onPressed: ()
                    {
                      Navigator.pop(context);
                    },
                    child: Text('취소', textScaleFactor: 1.0, style: TextStyle(color: Colors.grey.shade600))
                ),
              ),

              Container(
                height: 40,
                width: 120,
                margin: EdgeInsets.only(bottom: 10),
                child: TextButton(
                    style: TextButton.styleFrom(
                        elevation: 5.0,
                        backgroundColor: mainColor,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1.0, color: mainColor),
                            borderRadius: BorderRadius.circular(5.0))),
                    onPressed: () async
                    {

                    },
                    child: Text('확인', textScaleFactor: 1.0, style: TextStyle(color: Colors.white))
                ),
              ),

            ],
          );
        });
  }


  /// Dio Exception Dialog
  static showDioDialog(String title, String text, BuildContext mainContext, {required Function onPositive}) {
    return showDialog(
        context: mainContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            title: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, textScaleFactor: 0.85, style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 190,
                      child: Text(text, textAlign: TextAlign.center, textScaleFactor: 0.85)),
                ],
              ),
            ),
            contentPadding:EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
            actionsAlignment: MainAxisAlignment.center,
            actions: <Widget>[


              Container(
                width: 240,
                height: 40,
                margin: EdgeInsets.only(bottom: 10),
                child: TextButton(
                    style: TextButton.styleFrom(
                        elevation: 3.0,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
                    onPressed: () => onPositive(),
                    child: Text('확인', textScaleFactor: 1.0, style: TextStyle(color: Colors.grey.shade600))
                ),
              )

            ],
          );
        });
  }

  /// bluetooth off state
  static showMenuDialog(BuildContext mainContext, {required double height}) {
    return showDialog(
        context: mainContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            content: Container(
              padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
              height: height,
              width: 300,
              child: Column(
                  children: [
                    Icon(Icons.error, color: mainColor, size: 40),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text('블루투스 상태', textScaleFactor: 1.1, style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: 190,
                              child: Text('블루투스 기능을 활성화 해주세요.', textAlign: TextAlign.center, textScaleFactor: 0.85)),
                        ],
                      ),
                    ),

              ]),
            ),
            contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            actionsAlignment: MainAxisAlignment.center,
            actions: <Widget>[
              Container(
                height: 40,
                width:  240,
                margin: EdgeInsets.only(bottom: 10),
                child: TextButton(
                    style: TextButton.styleFrom(
                        elevation: 5.0,
                        backgroundColor: mainColor,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1.0, color: mainColor),
                            borderRadius: BorderRadius.circular(5.0))),
                    onPressed: () => {
                      Navigator.pop(context)
                    },
                    child: Text('확인', textScaleFactor: 1.0, style: TextStyle(color: Colors.white))
                ),
              ),

            ],
          );
        });
  }




  /// 팝업 형태로 표시
  static popup(context, {required Widget child, double width = 300, required double height,  double padding = 10,
    bool bBackgroundTapPop = true, Color color = Colors.white, double round = 15.0}) async {

    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(round))),
            contentPadding: EdgeInsets.all(padding),
            content: Container(
                width: width,
                //height:  // 호출 하는 곳의 column에서 mainAxisSize: MainAxisSize.min 적용 필요
                child: child
            ),
          );
        }
    );
  }



  static showStartEndDialog(BuildContext mainContext, {required Function onPositive}) {
   late String searchStartDate;
   late String searchEndDate;

    return showDialog(
        context: mainContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            content: Container(
              width: 100,
              height: 300,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                  color: Colors.white),
              child: SfDateRangePicker(
                minDate: DateTime(2000),
                maxDate: DateTime.now().add(Duration(hours: 1)),
                onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                  if (args.value is PickerDateRange) {
                    searchStartDate = args.value.startDate.toString().substring(0, 10).replaceAll('-','');
                    searchEndDate = args.value.endDate != null ? args.value.endDate.toString().substring(0, 10).replaceAll('-','') : searchStartDate;
                  }
                },
                selectionMode: DateRangePickerSelectionMode.range,
                monthCellStyle: const DateRangePickerMonthCellStyle(
                  textStyle: TextStyle(color: Colors.black),
                  todayTextStyle: TextStyle(color: Colors.black),
                ),
                startRangeSelectionColor: Colors.blueAccent,
                endRangeSelectionColor: Colors.blueAccent,
                rangeSelectionColor: Colors.blueAccent,
                selectionTextStyle: const TextStyle(color: Colors.white),
                todayHighlightColor: Colors.black,
                selectionColor: Colors.deepPurple,
                // backgroundColor: Colors.deepPurple,
                allowViewNavigation: false,
                view: DateRangePickerView.month,
                headerHeight: 30,
                headerStyle: const DateRangePickerHeaderStyle(
                    textAlign: TextAlign.center,
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18)),
                monthViewSettings:
                const DateRangePickerMonthViewSettings(
                  enableSwipeSelection: false,
                ),
              ),
            ),
            contentPadding: EdgeInsets.fromLTRB(20, 30, 30, 10),
            actionsAlignment: MainAxisAlignment.center,
            actions: <Widget>[
              Container(
                height: 40,
                width:  140,
                margin: EdgeInsets.only(bottom: 10),
                child: TextButton(
                    style: TextButton.styleFrom(
                        elevation: 5.0,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1.0, color: Colors.white),
                            borderRadius: BorderRadius.circular(5.0))),
                    onPressed: () => {
                      Navigator.pop(context)
                    },
                    child: Text('취소', textScaleFactor: 1.0, style: TextStyle(color: mainColor))
                ),
              ),
              Container(
                height: 40,
                width:  140,
                margin: EdgeInsets.only(bottom: 10),
                child: TextButton(
                    style: TextButton.styleFrom(
                        elevation: 5.0,
                        backgroundColor: mainColor,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1.0, color: mainColor),
                            borderRadius: BorderRadius.circular(5.0))),
                    onPressed: () => onPositive(searchStartDate, searchEndDate),
                    child: Text('확인', textScaleFactor: 1.0, style: TextStyle(color: Colors.white))
                ),
              ),

            ],
          );
        });
  }
}