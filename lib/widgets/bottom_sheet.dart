import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:provider/provider.dart';
import 'package:urine/main.dart';
import 'package:urine/model/authorization.dart';
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
    return Container(
      color: Color(0xFF737373),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.only(topLeft:Radius.circular(20), topRight: Radius.circular(20))),
        padding: EdgeInsets.only(
            bottom: bottomPadding(context)),
        child: SizedBox(
          height: 390,
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
                          padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
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

  String deviceStateText = '유린기 OFF'; // 디바이스 상태 Text

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF737373),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.only(topLeft:Radius.circular(20), topRight: Radius.circular(20))),
        padding: EdgeInsets.only(
            bottom: bottomPadding(context)),
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
                      decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    )
                  ],
                ),

                Container(
                  height: 410,
                  margin: EdgeInsets.only(top: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [
                          Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                            elevation: 4,
                            child: Container(
                              height: 230,
                              width: (widget.size.width/2) -18 ,
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.bluetooth, color: Colors.blue, size: 80),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Frame.myText(
                                      text: '블루투스 전원을 활성화 해주세요.',
                                      fontSize: 1.0,
                                      maxLinesCount: 2,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),

                                  Consumer<BluetoothStateProvider>(
                                    builder: (context, provider, child){
                                      bluetoothState = provider.state;
                                      return Padding(
                                        padding: const EdgeInsets.only(left: 5, top: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            MSHCheckbox(
                                              size: 25,
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
                                ],
                              ),
                            ),
                          ),

                          Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                            child: Container(
                              height: 230,
                              width: (widget.size.width/2) - 18,
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.devices, color: Colors.blue, size: 80),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Frame.myText(
                                      text: '유린기가 켜져있는지 확인 해주세요.',
                                      fontSize: 1.0,
                                      maxLinesCount: 2,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      setState((){
                                        isDevice = !isDevice;
                                        deviceStateText = isDevice ? '유린기 ON' : '유린기 OFF';
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5, top: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          MSHCheckbox(
                                            size: 25,
                                            value: isDevice,
                                            colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                                              checkedColor: Colors.blue,
                                            ),
                                            style: MSHCheckboxStyle.stroke,
                                            onChanged: (selected) {
                                              setState(() {
                                                isDevice = selected;
                                                deviceStateText = '유린기 ON';
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
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),


                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 15, 8, 40),
                        child: Frame.myText(
                          text: '✓ 모든 체크박스가 체크 되어 있어야됩니다.\n✓ 블루투스를 켜시면 자동으로 체크됩니다.',
                          fontSize: 0.95,
                          maxLinesCount: 2,
                          fontWeight: FontWeight.w600,
                          color: Colors.redAccent,
                        ),
                      ),

                      Visibility (
                          visible: bluetoothState && isDevice,
                          child: PreparationToSearchButton(
                              context: context,
                              text: '준비 완료',
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
    return Container(
      color: Color(0xFF737373),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.only(topLeft:Radius.circular(20), topRight: Radius.circular(20))),
        padding: EdgeInsets.only(
            bottom: bottomPadding(context)),
        child: SizedBox(
          height: widget.size.height * 0.8,
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

            widget.urineModel == null ? Column(
              children: [
                EmptyView(text: '검사 결과를 가져오지 못했습니다.\n 다시 시도 바랍니다.',),
                /// 버튼 추가 필요!!!
              ],
            )
                :
            Container(
              height: (widget.size.height * 0.78) - 30,
              child: Container(
                padding: EdgeInsets.only(left: 0, right: 0, top: 15),
                child: ListView(
                  children:
                  [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            /// text
                            _buildViewText(),

                            /// 그래프
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
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
                                                Text('현재 서버가 불안정합니다. 다시 시도 바랍니다.',
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
                    ),

                    _buildMeasurementTime(),
                              Container(
                                height: 700,
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount:
                                      widget.urineModel?.urineList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return FastestResultListItem(
                                      index: index,
                                      fastestResult:
                                          widget.urineModel?.urineList,
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
              ],
            ),
          ),
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
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 10 ,10),
        child: Container(
          width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Frame.myText(
                  text: '✓ ${Authorization().name}님',
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


  /// sheet bottom
  double bottomPadding(BuildContext ctx) {
    var result = MediaQuery.of(ctx).viewInsets.bottom;
    if (result == 0) result = 10;
    return result;
  }
}