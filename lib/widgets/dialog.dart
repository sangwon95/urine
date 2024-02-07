import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:urine/main.dart';
import 'package:urine/utils/etc.dart';
import '../model/authorization.dart';
import '../utils/color.dart';

class CustomDialog{

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
                  Text(title, textScaleFactor: 0.95, style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            content: SizedBox(
              height: 135,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                    child: SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: 220,
                              child: Text(text, textAlign: TextAlign.center, textScaleFactor: 0.85, style: TextStyle(fontWeight: FontWeight.w500))),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: TextButton(
                          style: TextButton.styleFrom(
                              elevation: 5.0,
                              backgroundColor: mainColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(10.0),
                                      bottomLeft: Radius.circular(10.0))
                              )),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('확인', textScaleFactor: 1.1, style: TextStyle(color: Colors.white))
                      ),
                    ),
                  ),
                ],
              ),
            ),
            contentPadding: EdgeInsets.all(0),
            actionsAlignment: MainAxisAlignment.end,
            actionsPadding: EdgeInsets.all(0),
            // actions: [
            //   Visibility(
            //     visible: isCancelBtn,
            //     child: Container(
            //       width: 120,
            //       height: 40,
            //       margin: EdgeInsets.only(bottom: 10),
            //       child: TextButton(
            //           style: TextButton.styleFrom(
            //               elevation: 3.0,
            //               backgroundColor: Colors.white,
            //               shape: RoundedRectangleBorder(
            //                  // side: BorderSide(width: 1.0, color: Colors.grey.shade100),
            //                   borderRadius: BorderRadius.circular(15.0))),
            //           onPressed: ()
            //           {
            //             Navigator.pop(context);
            //           },
            //           child: Text('취소', textScaleFactor: 1.0, style: TextStyle(color: Colors.grey.shade600))
            //       ),
            //     ),
            //   ),
            //
            //   Expanded(
            //     child: Container(
            //       height: 40,
            //       width: isCancelBtn ? 120 : double.infinity,
            //       child: TextButton(
            //           style: TextButton.styleFrom(
            //               elevation: 5.0,
            //               backgroundColor: mainColor,
            //               shape: RoundedRectangleBorder(
            //                   side: BorderSide(width: 1.0, color: mainColor),
            //                   borderRadius: BorderRadius.only(
            //                       bottomLeft: Radius.circular(15),
            //                       bottomRight: Radius.circular(15),
            //                   )
            //               )),
            //           onPressed: ()
            //           {
            //             Navigator.pop(context);
            //           },
            //           child: Text('확인', textScaleFactor: 1.0, style: TextStyle(color: Colors.white))
            //       ),
            //     ),
            //   ),
            // ],
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
                    onPressed: () => onPressed(),
                    child: Text('확인', textScaleFactor: 1.0, style: TextStyle(color: Colors.white))
                ),
              ),

            ],
          );
        });
  }

  /// 설정 다이얼 로그
  static showSettingDialog({
    required String title,
    required String text,
    required BuildContext mainContext,
    required Function onPressed
  }) {
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
            content: SizedBox(
              height: 122,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: 190,
                            height: 31,
                            child: Text(text, textAlign: TextAlign.center, textScaleFactor: 0.85)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 34),
                    child: Row(
                      children:
                      [
                        Expanded(
                          child: Container(
                            width: 60,
                            height: 45,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    elevation: 3.0,
                                    backgroundColor: mainColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(5.0)))),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('취소', textScaleFactor: 1.0, style: TextStyle(color: Colors.white))
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 45,
                            width: 60,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    elevation: 5.0,
                                    backgroundColor: mainColor,
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(width: 1.0, color: mainColor),
                                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(5.0)))),
                                onPressed: () => onPressed(),
                                child: Text('확인', textScaleFactor: 1.0, style: TextStyle(color: Colors.white))
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            contentPadding: EdgeInsets.all(0.0),
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
                        backgroundColor: mainColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
                    onPressed: () => onPositive(),
                    child: Text('확인', textScaleFactor: 1.0, style: TextStyle(color: Colors.white))
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



  /// 성분 분석
  /// 분석 중일때 나오는 다이얼 로그
  static showAIDialog(String title, String text, BuildContext mainContext, bool isCancelBtn) {
    return showDialog(
        context: mainContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              // 뒤로가기 버튼을 이용한 닫힘을 방지
              return false;
            },
            child: AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              title: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    Text(title, textScaleFactor: 0.95, style: TextStyle(fontWeight: FontWeight.bold)),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25),
                      child: SpinKitFadingFour(
                          color: mainColor,
                          size: 70
                      ),
                    ),
                    Text(
                        '${Authorization().name}님 데이터 분석중입니다.',
                        textScaleFactor: 0.85,
                        style: TextStyle(fontWeight: FontWeight.bold, color: mainColor)
                    ),
                  ],
                ),
              ),
              content: SizedBox(
                height: 100,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: SizedBox(
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: 230,
                                child: Text(text, textAlign: TextAlign.center, textScaleFactor: 0.85, style: TextStyle(fontWeight: FontWeight.w500))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              contentPadding: EdgeInsets.all(0),
              actionsAlignment: MainAxisAlignment.end,
              actionsPadding: EdgeInsets.all(0),
            ),
          );
        });
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

  static showCalenderDialog(BuildContext mainContext, {required Function onPositive}) {
    late DateTime searchDate;

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
                onSelectionChanged: (DateRangePickerSelectionChangedArgs date)
                {
                 String substringDate = date.value.toString().substring(0, 10).replaceAll('-','');

                  int year     = int.parse(substringDate.substring(0, 4));
                  int month    = int.parse(substringDate.substring(4, 6));
                  int day      = int.parse(substringDate.substring(6, 8));
                  searchDate = DateTime(year, month, day);
                },
                selectionMode: DateRangePickerSelectionMode.single,
                monthCellStyle: const DateRangePickerMonthCellStyle(
                  textStyle: TextStyle(color: Colors.black),
                  todayTextStyle: TextStyle(color: Colors.black),
                ),
                selectionTextStyle: const TextStyle(color: Colors.white),
                todayHighlightColor: Colors.redAccent,
                selectionColor: mainColor,
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
                        elevation: 1.0,
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
                        backgroundColor: mainColor,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1.0, color: mainColor),
                            borderRadius: BorderRadius.circular(5.0))),
                    onPressed: () => onPositive(searchDate),
                    child: Text('확인', textScaleFactor: 1.0, style: TextStyle(color: Colors.white))
                ),
              ),

            ],
          );
        });
  }
}