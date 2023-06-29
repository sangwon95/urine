/*

import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:urine/main.dart';
import 'package:urine/utils/dio_client.dart';
import 'package:urine/utils/frame.dart';
import 'package:urine/widgets.dart';

import '../model/result_list.dart';
import '../utils/color.dart';
import '../widgets/list_item.dart';

class ResultListPage extends StatefulWidget {
  const ResultListPage({Key? key}) : super(key: key);

  @override
  State<ResultListPage> createState() => _ResultListPageState();
}

class _ResultListPageState extends State<ResultListPage> {

  final String title = '검사 내역';
  List<ResultList> resultList = [];
  List<Map<String, String>> groupResultList = [];
  ScrollController _scrollController = ScrollController();
  int pageIndex = 1;

  String searchStartDate = '';
  String searchEndDate   = '';

  @override
  void initState() {
    super.initState();

    _scrollListener();

  }

  Future<Null> _refreshList() async {
    setState(() { });
    return null;
  }
    @override
    Widget build(BuildContext context) {

      return Scaffold(
        appBar: Frame.myAppbar(
            title,
            isIconBtn: true,
            icon: Icons.search_rounded,
            onPressed: (){
              showEndConsultationDialog(context, onPositive: ()=>{ Navigator.pop(context)});
            }
        ),
        body: FutureBuilder(
          future: client.dioResultList(pageIndex, searchStartDate, searchEndDate),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(snapshot.error.toString().replaceAll('Exception: ', ''),
                            textScaleFactor: 1.0, style: TextStyle(color: Colors.black)),
                        InkWell(
                            onTap: () => {
                              searchStartDate = '',
                              searchEndDate = '',
                              _refreshList(),
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.replay, size: 30),
                            ))
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
              groupResultList.clear();

              if (pageIndex == 1) {
                resultList = snapshot.data;
              }
              else {
                resultList = resultList..addAll(snapshot.data);
              }
              for (var elements in resultList) {
                String referenceDate = elements.datetime.substring(0, 8);
                if (elements.datetime.contains(referenceDate)) {
                  Map<String, String> resultMap = {};
                  resultMap['datetime'] = elements.datetime;
                  resultMap['positiveCnt'] = elements.positiveCnt;
                  resultMap['negativeCnt'] = elements.negativeCnt;
                  resultMap['group'] = referenceDate;

                  groupResultList.add(resultMap);
                }
              }

              mLog.d(groupResultList.toString());
            }

            return resultList.isEmpty ? EmptyView(text: '저장된 데이터가 없습니다.',) : Container(
                child: GroupedListView<dynamic, String>(
                  controller: _scrollController,
                  elements: groupResultList,
                  groupBy: (element) => element['group'],
                  groupComparator: (value1, value2) => value2.compareTo(value1),
                  order: GroupedListOrder.ASC,
                  useStickyGroupSeparators: false,
                  groupSeparatorBuilder: (String value) => GroupListHeader(headerText: value),
                  itemBuilder: (c, element)
                  {
                    return ResultListItem(element: element);
                  },

                )
            );
          },
        ),
      );
    }

    /// 스크롤 이벤트 리스너
    void _scrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.offset == _scrollController.position.maxScrollExtent) {
        if (resultList.length % 10 == 0) {
          ++pageIndex;
          print('====> pageCount : ' + pageIndex.toString());
          _refreshList();
        }
      }
    });
  }


  /// 상담 종료 팝업
  /// HomePage, MenuPage
   showEndConsultationDialog(BuildContext mainContext, {required Function onPositive}) {
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
                    onPressed: () => {
                      mLog.d('Start Date: $searchStartDate'),
                      mLog.d('End Date: $searchEndDate'),
                      Navigator.pop(context),
                      setState(() {})
                    },
                    child: Text('확인', textScaleFactor: 1.0, style: TextStyle(color: Colors.white))
                ),
              ),

            ],
          );
        });
  }

}





*/
