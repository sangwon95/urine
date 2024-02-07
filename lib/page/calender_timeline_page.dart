import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:urine/main.dart';
import 'package:urine/page/loading_page.dart';
import 'package:urine/utils/color.dart';
import 'package:urine/utils/etc.dart';
import 'package:urine/utils/frame.dart';
import 'package:intl/intl.dart';

import '../model/result_list.dart';
import '../utils/dio_client.dart';
import '../widgets.dart';
import '../widgets/dialog.dart';
import '../widgets/list_item.dart';

class CalenderTimeLinePage extends StatefulWidget {
  const CalenderTimeLinePage({Key? key}) : super(key: key);

  @override
  State<CalenderTimeLinePage> createState() => _CalenderTimeLinePageState();
}

class _CalenderTimeLinePageState extends State<CalenderTimeLinePage> {

  /// DatePickerTimeLine Controller
  DatePickerController _controller = DatePickerController();

  /// ListView ScrollController
  ScrollController _scrollController = ScrollController();

  /// 최상단 날짜
  late String selectedCurrentDateTime;

  /// 초기 선택할 날짜
  late DateTime initialSelectedDate = DateTime.now();

  /// 결과 페이지 인덱스
  int pageIndex = 1;

  /// 서버로부터 받은 결과 데이터 리스트
  List<ResultList> resultList = [];

  late Size size;

  @override
  void initState() {
    super.initState();

    _scrollResultListListener();

    _updateAnimateDate(initialSelectedDate);

    /// 첫 빌드시 오늘 날짜로 설정 한다.
    selectedCurrentDateTime =
        DateFormat("yyyy.MM.dd").format(initialSelectedDate);
  }


  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: Frame.myImageAppbar(),

      body: SafeArea(
        child: Column(
          children:
          [
            _buildCalenderText(context),

            Etc.solidLine(context),

            _buildDataPickerTimeLine(),

            _buildResultList()
          ],
        ),
      ),
    );
  }


  /// 현재 날짜 설정
  _setCurrentDateTime(DateTime searchDate){
    pageIndex = 1;
    initialSelectedDate = searchDate;
    selectedCurrentDateTime = DateFormat('yyyy.MM.dd').format(searchDate).toString();
  }


  /// 스크롤 이벤트 리스너
  void _scrollResultListListener() {
    _scrollController.addListener(() {
      if (_scrollController.offset == _scrollController.position.maxScrollExtent) {
        if (resultList.length % 10 == 0) {
          ++pageIndex;
          mLog.i('====> pageCount : ' + pageIndex.toString());
          _refreshList();
        }
      }
    });
  }


  /// 결과 리스트 갱신
  Future<Null> _refreshList() async {
    setState(() {
      Navigator.of(context).push(LoadingPage());
    });
    // 비동기 작업 수행
    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        Navigator.pop(context);
      });
    });
    return null;
  }


  /// 해당 날짜에 맞춰 DatePikerTimeLine 위치를 변경한다.
  _updateAnimateDate(DateTime dateTime) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.animateToDate(dateTime);
    });
  }


  /// Calender Text Widget
  /// 클릭 시 달력 창이 뜬다.
  /// 달력 다자인 수정 필요
  _buildCalenderText(BuildContext context) {
    return InkWell(
      onTap: () =>
      {
        CustomDialog.showCalenderDialog(
          context,
          onPositive: (searchDate) => {
            setState(() {
              mLog.d('get searchDate: ${searchDate}');
              _setCurrentDateTime(searchDate);
              Navigator.pop(context);

              _updateAnimateDate(searchDate);
            })
          },
        )
      },
      child: Container(
        height: 50,
        width: double.infinity,
        decoration:  BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.bottomLeft,
              end: FractionalOffset.topRight,
              colors: [
                Color(0xff4182db),
                Color(0xff6fbcd2),
              ],
              stops: [0.1, 1.0],
            )
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Frame.myText(
                  text: selectedCurrentDateTime,
                  fontSize: 1.3,
                  color: Colors.white
              ),
              Icon(Icons.keyboard_arrow_down, color: Colors.white)
            ],
          ),
        ),
      ),
    );
  }


  /// Custom TimeLine Widget
  _buildDataPickerTimeLine() {
    return Container(
        height: 120,
        decoration:  BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.bottomLeft,
              end: FractionalOffset.topRight,
              colors: [
                Color(0xff4182db),
                Color(0xff6fbcd2),
              ],
              stops: [0.1, 1.0],
            )
        ),
        child: DatePicker(
          DateTime(2023, 1, 1),
          initialSelectedDate: initialSelectedDate,
          controller: _controller,
          daysCount: 365, //@ 조정이 필요합니다.
          selectionColor: Colors.white,
          selectedTextColor: mainColor,
          dateTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          dayTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
          monthTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
          locale: 'ko-KR',
          onDateChange: (date) {
            // New date selected
            setState(() {
              mLog.d('$date');
              _setCurrentDateTime(date);
              _updateAnimateDate(date);
            });
          },
        )
    );
  }


  /// 날짜(일) 에 따른 결과 내역 리스트
  _buildResultList(){
    return Expanded(
      child: FutureBuilder(
        future: client.dioResultList(pageIndex, selectedCurrentDateTime.replaceAll('.',''), selectedCurrentDateTime.replaceAll('.','')),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('images/empty_image.png', width: 90, height: 90),
                      SizedBox(height: 15),
                      Text(snapshot.error.toString().replaceAll('Exception: ', ''),
                          textScaleFactor: 1.1, style: TextStyle(color: Colors.black)),
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
              resultList.clear();
              resultList = snapshot.data;
              for(var value in resultList){
                mLog.d('value datetime : ${value.datetime}');
              }
            }
            else {
              resultList = resultList..addAll(snapshot.data);
            }
          }

          return resultList.isEmpty ? EmptyView(text: '저장된 데이터가 없습니다.',) :
          Container(
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
    );
  }
}
