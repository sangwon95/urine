
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:urine/main.dart';
import 'package:urine/utils/dio_client.dart';
import 'package:urine/utils/frame.dart';
import 'package:urine/widgets.dart';

import '../model/result_list.dart';
import '../utils/color.dart';
import '../utils/etc.dart';
import '../widgets/list_item.dart';

/// 결과 화면
class ResultListPage extends StatefulWidget {
  const ResultListPage({Key? key}) : super(key: key);

  @override
  State<ResultListPage> createState() => _ResultListPageState();
}

class _ResultListPageState extends State<ResultListPage> with TickerProviderStateMixin {

  final String title = '검사 내역';
  List<ResultList> resultList = [];
  List<ResultList> recentResultList = [];
  ScrollController _scrollController = ScrollController();
  ScrollController _recentScrollController = ScrollController();
  int recentPageIndex = 1;
  int pageIndex = 1;

  late String startDateRecent;
  late String endDateRecent;

  late Size size;
  late TabController _tabController;

  /// 전체 결과 리스트
  String searchEndDate = '';
  String searchStartDate = '';

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,  //vsync에 this 형태로 전달해야 애니메이션이 정상 처리됨
    );

    super.initState();
    _setRecentSearchDate();
    _scrollListener();
  }

  /// 최근 1주일 DateTime 초기화
  _setRecentSearchDate() {
    startDateRecent = Etc.setDateDuration(7);
    endDateRecent = Etc.setDateDuration(0);
  }

  Future<Null> _refreshList() async {
    setState(() { });
    return null;
  }
    @override
    Widget build(BuildContext context) {
      size = MediaQuery.of(context).size;
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: Frame.myAppbar(
            title,
            isIconBtn: false,
            icon: Icons.search_rounded,
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: TabBar(
                tabs: [
                  Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: Text(
                      '최근',
                    ),
                  ),
                  Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: Text(
                      '전체',
                    ),
                  ),
                ],
                indicator: BoxDecoration(
                  color: mainColor
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                controller: _tabController,
              ),
            ),
            
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  FutureBuilder(
                    future: client.dioResultList(recentPageIndex, searchStartDate, searchEndDate),
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
                                        _refreshList(),
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: const Icon(Icons.replay, size: 30),
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
                        if (recentPageIndex == 1) {
                          recentResultList = snapshot.data;
                        }
                        else {
                         recentResultList = recentResultList..addAll(snapshot.data);
                        }
                      }

                      return recentResultList.isEmpty ? EmptyView(text: '저장된 데이터가 없습니다.',) : Container(
                          margin: EdgeInsets.only(bottom: 15),
                          child: ListView.builder(
                              controller: _recentScrollController,
                              itemCount: recentResultList.length<6 ? recentResultList.length : 5,
                              itemBuilder: (BuildContext context, int index) =>
                                  ResultListItem(
                                      resultListItem: recentResultList[index],
                                      size: size,
                                      context: context
                                  )
                          )
                      );
                    },
                  ),


                  FutureBuilder(
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
                        if (pageIndex == 1) {
                          resultList = snapshot.data;
                        }
                        else {
                          resultList = resultList..addAll(snapshot.data);
                        }
                      }

                      return resultList.isEmpty ? EmptyView(text: '저장된 데이터가 없습니다.',) : Container(
                          margin: EdgeInsets.only(bottom: 15),
                          child: ListView.builder(
                              controller: _scrollController,
                              itemCount: resultList.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  ResultListItem(
                                      resultListItem: resultList[index],
                                      size: size,
                                      context: context
                                  )
                          )
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    /// 스크롤 이벤트 리스너
    void _scrollListener() {
    _recentScrollController.addListener(() {
      if (_recentScrollController.offset == _recentScrollController.position.maxScrollExtent) {
        if (resultList.length % 10 == 0) {
          ++recentPageIndex;
          print('====> recentPageCount : ' + recentPageIndex.toString());
          _refreshList();
        }
      }
    });

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





