import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:provider/provider.dart';
import 'package:urine/main.dart';
import 'package:urine/model/authorization.dart';
import 'package:urine/page/ai_result_page.dart';
import 'package:urine/providers/bluetooth_state_provider.dart';
import 'package:urine/utils/etc.dart';
import 'package:urine/widgets/button.dart';
import 'package:intl/intl.dart';
import 'package:urine/widgets/dialog.dart';

import '../model/chart.dart';
import '../model/recent.dart';
import '../model/urine_model.dart';
import '../page/recent_page.dart';
import '../utils/color.dart';
import '../utils/constants.dart';
import '../utils/dio_client.dart';
import '../utils/frame.dart';
import '../widgets.dart';
import 'line_chart.dart';

class TermsBottomSheet extends StatefulWidget {

  @override
  State<TermsBottomSheet> createState() => _TermsBottomSheetState();
}

class _TermsBottomSheetState extends State<TermsBottomSheet> {

  /// agree flag list
  List<bool> agree = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    mLog.d('이용약관 화면 갱신');
    return Container(
      color: Color(0xFF737373),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.only(topLeft:Radius.circular(20), topRight: Radius.circular(20))),
        padding: EdgeInsets.only(
            bottom: bottomPadding(context)),
        child: SizedBox(
          height: 360,
          child: Container(
            padding: EdgeInsets.only(top: 15),
            child: Column(
              children: [
                /// 상단 내림 바
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 70, height: 3,
                      decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    )
                  ],
                ),

                Container(
                  padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      _buildRowCheckBox(0, '약관 전체 동의'),
                      Etc.solidLine(context),
                      _buildRowCheckBox(1, '서비스 이용 약관'),
                      _buildRowCheckBox(2, '개인정보 이용 약관'),
                      _buildRowCheckBox(3, '개인정보 제 3자 제공 동의'),

                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 45, 0, 0),
                          child: TermsButton(
                              btnName: '동의하기',
                              context: context,
                              agree: agree,
                          )
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),

        ),
      ),
    );
  }

  /// check box click area and text
  _buildRowCheckBox(int index, String headText) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children:
          [
            Transform.scale(
              scale: 1.1,
              child: Checkbox(
                  activeColor: mainColor,
                  checkColor: Colors.white,
                  shape: CircleBorder(side: BorderSide(color: mainColor)),
                  value: agree[index],
                  onChanged:(bool? value) {
                    setState(()
                    {
                      if(index == 0)
                      {
                        for(int i = 0 ; i<agree.length ; i++)
                          agree[i] = value!;
                      }
                      else{
                        agree[index] = value!;
                      }
                    });
                  }),
            ),
            Container(
                child: Row(
                    children:
                    [
                      Text(headText, softWrap: true, textScaleFactor: index == 0 ? 1.2 : 1.0,
                          style: TextStyle(fontWeight: index == 0 ? FontWeight.w600 : FontWeight.w500)),
                      Visibility(
                          visible:index == 0 ? false : true,
                          child:Text(' (필수)', softWrap: true, textScaleFactor: 1.0, style: TextStyle(color: Colors.red))),
                    ]
                )),

          ],
        ),


        Visibility(
          visible: index == 0 ? false : true,
          child: Text(
            '보기',
            textScaleFactor: 0.9,
            style: TextStyle(
              color: Colors.grey,
              decoration: TextDecoration.underline,
            ),
          ),
        )
      ],
    );
  }

  /// sheet bottom
  double bottomPadding(BuildContext ctx) {
    var result = MediaQuery.of(ctx).viewInsets.bottom;
    if (result == 0) result = 10;
    return result;
  }
}


/// 검사 사전 준비 BottomSheet
class PreparationBottomSheet extends StatefulWidget {
  final Size size;
  final Function(UrineModel) onBackCallbackResult;
  PreparationBottomSheet({required this.size, required this.onBackCallbackResult});

  //final Function(BluetoothDevice) onBackCallbackConnect;
  //PreparationBottomSheet({required this.size, required this.onBackCallbackConnect});

  @override
  State<PreparationBottomSheet> createState() => _PreparationBottomSheetState();
}

class _PreparationBottomSheetState extends State<PreparationBottomSheet> {

  /// step 0: 검사 준비
  bool isDevice       = false; // 디바이스 상태
  bool bluetoothState = false;// 블루투스 상태 Text

  String deviceStateText = '검사기 OFF'; // 디바이스 상태 Text

  late BluetoothStateProvider _bluetoothStateProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addBluetoothStateLister();
  }
  @override
  Widget build(BuildContext context) {
    _bluetoothStateProvider = Provider.of<BluetoothStateProvider>(context);
    return Container(
      color: Color(0xFFf0f0f0),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.only(topLeft:Radius.circular(20), topRight: Radius.circular(20))),
        padding: EdgeInsets.only(bottom: bottomPadding(context)),
        child: SizedBox(
          height: 490,
          child: Container(
            padding: EdgeInsets.only(top: 15),
            child: Column(
              children: [
                /// 상단 내림 바
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 70, height: 3,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                    )
                  ],
                ),

                Container(
                  height: 440,
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20, right: 5),
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                elevation: 4,
                                child: Container(
                                  height: 230,
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:
                                    [
                                      Consumer<BluetoothStateProvider>(
                                        builder: (context, provider, child){
                                          bluetoothState = provider.state;
                                          return Padding(
                                            padding: const EdgeInsets.only(bottom: 15),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                MSHCheckbox(
                                                  size: 20,
                                                  value: bluetoothState,
                                                  colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                                                    checkedColor: Colors.blue,
                                                  ),
                                                  style: MSHCheckboxStyle.stroke,
                                                  onChanged: (selected) { },
                                                ),
                                                SizedBox(width: 10),
                                                Frame.myText(
                                                    text: bluetoothState ? '블루투스 ON' : '블루투스 OFF',
                                                    fontWeight: FontWeight.w600,
                                                    color: bluetoothState ? Colors.blue : Colors.grey,
                                                    fontSize: 1.0
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                      Image.asset('images/bluetooth_icon.png', width: 80, height: 80),
                                      SizedBox(height: 20),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Frame.myText(
                                          text: '블루투스 전원을\n활성화 해주세요.',
                                          fontSize: 1.0,
                                          color: Colors.grey.shade600,
                                          maxLinesCount: 2,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5, right: 20),
                              child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                child: Container(
                                  height: 230,
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          setState((){
                                            isDevice = !isDevice;
                                            deviceStateText = isDevice ? '검사기 ON' : '검사기 OFF';
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(bottom: 15),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              MSHCheckbox(
                                                size: 20,
                                                value: isDevice,
                                                colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                                                  checkedColor: Colors.blue,
                                                ),
                                                style: MSHCheckboxStyle.stroke,
                                                onChanged: (selected) {
                                                  setState(() {
                                                    isDevice = selected;
                                                    deviceStateText = '검사기 ON';
                                                  });
                                                },
                                              ),
                                              SizedBox(width: 10),
                                              Frame.myText(
                                                  text: deviceStateText,
                                                  fontWeight: FontWeight.w600,
                                                  color: isDevice ? Colors.blue : Colors.grey,
                                                  fontSize: 1.0
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Image.asset('images/power_icon.png',width: 80, height: 80),
                                      SizedBox(height: 20),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Frame.myText(
                                          text: '검사기가 켜져있는지\n확인 해주세요.',
                                          fontSize: 1.0,
                                          color: Colors.grey.shade600,
                                          maxLinesCount: 2,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 25, 0, 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Image.asset('images/check.png'),
                            SizedBox(width: 10),
                            Frame.myText(
                              text: '모든 체크박스가 체크 되어 있어야됩니다.',
                              fontSize: 1.1,
                              maxLinesCount: 2,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 15, 8, 35),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset('images/check.png'),
                            SizedBox(width: 10),
                            Frame.myText(
                              text: '블루투스를 켜시면 자동으로 체크됩니다.',
                              fontSize: 1.1,
                              maxLinesCount: 2,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                            ),
                          ],
                        ),
                      ),

                      Visibility (
                          visible: bluetoothState && isDevice,
                          child: PreparationToSearchButton(
                              context: context,
                              text: '검사 진행',
                              onBackCallbackResult: (UrineModel) => widget.onBackCallbackResult(UrineModel))
                            //onBackCallbackConnect: (BluetoothDevice) => widget.onBackCallbackConnect(BluetoothDevice))
                      )
                    ],
                  ),
                )
              ],
            ),
          ),

        ),
      ),
    );
  }

  /// 시스템 블루투스 on/off 상태 리스너
  _addBluetoothStateLister(){
    FlutterBluePlus.adapterState.listen((value){
      if (value == BluetoothAdapterState.off) {
        _bluetoothStateProvider.setStateOff();
      }
      else if(value == BluetoothAdapterState.on){
        _bluetoothStateProvider.setStateOn();
      } else {
        mLog.i('${value.toString()}');
      }
    });
  }

  /// sheet bottom
  double bottomPadding(BuildContext ctx) {
    var result = MediaQuery.of(ctx).viewInsets.bottom;
    if (result == 0) result = 10;
    return result;
  }
}


/// 검사 결과 화면
class FastestBottomSheet extends StatefulWidget {
  final UrineModel? urineModel;
  final Size size;

  FastestBottomSheet({required this.urineModel, required this.size});

  @override
  State<FastestBottomSheet> createState() => _FastestBottomSheetState();
}

class _FastestBottomSheetState extends State<FastestBottomSheet> {

  late List<ChartData> chartData = [];
  late List<Recent> chartListData = [];

  late String searchStartDate = Etc.setDateDuration(0);
  late String searchEndDate = Etc.setDateDuration(0);

  /// 검사 타입 DT01 ~ DT11으로 11종 으로 구성 되어 있다.
  late String inspectionType;
  late String inspectionItem;
  bool isScreenUpdate = true;

  int selectedIdx = 7;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// searchStartData, searchEndDate 날짜 초기 해야됨
    inspectionType = inspectionItemTypeList[6]; //DT01: 잠혈로 초기화
    inspectionItem =  inspectionItemList[6]; // 잠혈 Text
    _setSearchDate(180);

    print(widget.urineModel.toString());
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20))),
      padding: EdgeInsets.only(bottom: bottomPadding(context)),
      child: SizedBox(
        height: widget.size.height-35,
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children:
            [
              /// 상단 내림 바
              _buildTopCancelBar(),

              // 23.8.22
              // 건강 지수 생략 요청
              //_buildUserInfoBox(),

              /// 7일간의 추이 차트
              _buildMyHealthReportBox(),

              /// 건강 차트
              _buildResultList(),

              /// 해당 데이터 성분 분석 버튼
              _buildComponentAnalysisButton(),
            ],
          ),
        ),
      ),
    );
  }


  /// 상단 바 widget
  _buildTopCancelBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
            onTap: ()=> {Navigator.pop(context)},
            child: Icon(Icons.cancel_outlined, size: 30))
      ],
    );
  }


  /// 검사 결과 widget
  /// 이름, 건강점수, 검사시간을 표시한다.
  _buildUserInfoBox() {
    return Container(
      height: 140,
      width: double.infinity,
      decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: FractionalOffset.bottomLeft,
            end: FractionalOffset.topRight,
            colors:
            [
              Color(0xff4182db),
              Color(0xff6fbcd2),
            ],
            stops: [0.1, 1.0],
          )
      ),
      margin: const EdgeInsets.only(top: 10),
      child: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            Frame.myText(
                text: '${Authorization().name}님의',
                color: Colors.white,
                fontWeight: FontWeight.w600,
                maxLinesCount: 4,
                fontSize: 1.6,
                align: TextAlign.start
            ),

            SizedBox(height: 5),

            Frame.myText(
                text: '건강 상태는 80점 입니다.',
                color: Colors.white,
                fontWeight: FontWeight.w500,
                maxLinesCount: 2,
                fontSize: 1.2,
                align: TextAlign.start
            ),

            SizedBox(height: 30),

            Frame.myText(
                text: '검사 시간: '+DateFormat('yyyy년 MM월 dd일 HH시 mm분').format(DateTime.now()),
                color: Colors.white,
                fontWeight: FontWeight.w600,
                maxLinesCount: 1,
                fontSize: 0.9,
                align: TextAlign.start),
          ],
        ),
      ),
    );
  }


  /// 나의 건강 차트
  /// 최근 검사 결과 기반으로 차트로 보여준다.
  /// 예)오늘 가장 최신의 검사결과로 1개의 x축에 보여준다.
  _buildMyHealthReportBox() {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(vertical: 20),
      width: widget.size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xFFecf4f6)
      ),
      child: FutureBuilder(
        future: client.dioChartData(searchStartDate, searchEndDate),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

          if (snapshot.hasError) {
            mLog.e('${snapshot.error.toString()}');
            return Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Frame.myText(
                        text: '현재 서버가 불안정합니다.\n 다시 시도 바랍니다.',
                      )
                    ]))
            );
          }

          if (!snapshot.hasData) {
            return Container(
                child: Center(
                    child: SizedBox(
                        height: 40.0,
                        width: 40.0,
                        child: CircularProgressIndicator(strokeWidth: 5)))
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            if (isScreenUpdate) {
              isScreenUpdate = false;
              chartListData.clear();
              chartData.clear();

              chartListData = snapshot.data;

              for (var value in chartListData) {
                if (value.dataType == inspectionType){ // 타입구분자로 원하는 차트를 구성할 수 있다.
                  if (!chartData.any((element) => element.x
                      .toString()
                      .contains(Etc.setGroupDateTime(value.datetime)))) {
                    if (chartData.length < 7) {
                      chartData.add(ChartData(
                          x: Etc.setGroupDateTime(value.datetime),
                          y: int.parse(value.status)));
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
                width: widget.size.width - 100,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:
                    [
                      Container(
                        decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                          child: Frame.myText(
                              text: '$inspectionItem',
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              maxLinesCount: 1,
                              fontSize: 0.8,
                              align: TextAlign.start
                          ),
                        ),
                      ),

                      Frame.myText(
                        text: '나의 건강 리포트',
                        fontWeight: FontWeight.normal,
                        fontSize: 1.2,
                        color: mainColor,
                      ),

                      Container(
                        decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                          child: Frame.myText(
                              text: '$selectedIdx/11',
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              maxLinesCount: 1,
                              fontSize: 0.8,
                              align: TextAlign.start),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              SizedBox(
                  height: 90,
                  width: widget.size.width - 90,
                  child: BarChart()
                      .buildColumnSeriesMiniChart(chartData: chartData)),
            ],
          );
        },
      ),
    );
  }


  /// 성분 분석 버튼
  _buildComponentAnalysisButton(){
    return Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        width: double.infinity,
        child: TextButton(
            style: TextButton.styleFrom(
                elevation: 0.0,
                backgroundColor: mainColor,
                padding: EdgeInsets.all(17.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))),
            onPressed: () =>_fetchAIAnalyze(),
            child: Frame.myText(
              text: '성분 분석',
              fontWeight: FontWeight.w400,
              fontSize: 1.2,
              color: Colors.white,
            )
        )
    );
  }


  /// 결과 리스트
  _buildResultList() {
    if(widget.urineModel == null){
      Etc.showSnackBar(context, msg: 'null', durationTime: 3);
      mLog.d('_buildResultList null');
    } else {
      mLog.d('_buildResultList Not null${widget.urineModel?.blood.toString()}');
    }
    return widget.urineModel == null ?
    Column(
      children: [
        EmptyView(
          text: '검사 결과를 가져오지 못했습니다.\n 다시 시도 바랍니다.',
        ),
      ],
    )
    :
    Expanded(
      child: Container(
        padding: EdgeInsets.only(top: 15),
        child: Scrollbar(
          thickness: 2,
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView(
              children: [
                Container(
                  height: 700,
                  child: ListView.builder(
                    //physics: NeverScrollableScrollPhysics(),
                    physics: BouncingScrollPhysics(),
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
        ),
      ),
    );
  }


  _setSearchDate(int duration) {
    searchStartDate = Etc.setDateDuration(duration);
    searchEndDate   = Etc.setDateDuration(0);
  }


  _changeItem(int selectedIdx) {
    this.selectedIdx =  selectedIdx+1;
    setState(() {
      inspectionType = inspectionItemTypeList[selectedIdx]; //DT01: 잠혈로 초기화
      inspectionItem =  inspectionItemList[selectedIdx]; // 잠혈 Text
      isScreenUpdate = true;
    });
  }


  /// sheet bottom
  double bottomPadding(BuildContext ctx) {
    var result = MediaQuery.of(ctx).viewInsets.bottom;
    if (result == 0) result = 10;
    return result;
  }

  /// 성분 분석: 측정된 소변데이터로
  /// 한밭대학교에서 제공해주는 API 연동
  _fetchAIAnalyze() async {
    CustomDialog.showAIDialog(
        '성분 분석',
        '제공되는 데이터는 참고 용도로만 사용되어야 하며, 전문가와의 상담을 권장합니다.',
        context,
        false
    );

    Future.delayed(Duration(seconds: 5), () async {

      try {
        List<String>? resultList = widget.urineModel?.urineList;

        Map<String, dynamic> toMap = {
          "blood": resultList![0] == '0' ? "-" : "${resultList[0]}+",
          "bilirubin": resultList[1] == '0' ? "-" : "${resultList[1]}+",
          "urobilinogen": resultList[2] == '0' ? "-" : "${resultList[2]}+",
          "ketones": resultList[3] == '0' ? "-" : "${resultList[3]}+",
          "protein": resultList[4] == '0' ? "-" : "${resultList[4]}+",
          "nitrite": resultList[5] == '0' ? "-" : "${resultList[5]}+",
          "glucose": resultList[6] == '0' ? "-" : "${resultList[6]}+",
          "leukocytes": resultList[9] == '0' ? "-" : "${resultList[9]}+",
        };
        String result = await client.dioAI(toMap);

        if (result != 'ERROR' || result != 'unknown') {
          mLog.i('[AI result]: $result');
          Navigator.pop(context);
          Frame.doPagePush(context, AIResultPage(result: result));
          // CustomDialog.showMyDialog('AI 분석',
          //     '${Authorization().name}님의 검사 내역이 없습니다.', context, false);
        }
      } catch (e) {
        mLog.d('에러');
        Navigator.pop(context);
        CustomDialog.showMyDialog(
            'AI 성분분석', '정상적으로 처리 되지 않았습니다.\n다시 시도 해주세요.', context, false);
      }
    });
  }
}