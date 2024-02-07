
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:urine/model/authorization.dart';
import 'package:urine/model/urine_model.dart';
import 'package:urine/page/my_health_page.dart';
import 'package:urine/page/result_list_page.dart';
import 'package:urine/page/setting/setting_page.dart';
import 'package:urine/utils/dio_client.dart';
import 'package:urine/utils/etc.dart';
import 'package:urine/widgets/bottom_sheet.dart';

import '../main.dart';
import '../model/recent.dart';
import '../utils/color.dart';
import '../utils/frame.dart';
import '../utils/network_connectivity.dart';
import '../widgets/dialog.dart';
import 'ai_result_page.dart';
import 'chart_page.dart';
import 'package:geolocator/geolocator.dart';

/// Devices Name :
class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  final String title = '홈 화면';
  late Size size;
  var userName = '-';

  @override
  void initState() {
    super.initState();

    _checkPermission();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    /// 네트워크 연결 상태 확인
    NetWorkConnectivity(context: context);

    return Scaffold(
      backgroundColor: homeBackgroundColor,
      appBar: Frame.myImageAppbar(
          isIconBtn: true,
          onPressed: () => Frame.doPagePush(context, SettingPage())
      ),
      body: FutureBuilder(
        future:  _fetchUserName(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     Frame.myText(
                       text: '서버와 연결이 원활하지 않습니다.\n다시 시도 바랍니다.',
                       fontWeight: FontWeight.bold,
                       fontSize: 1.1,
                       maxLinesCount: 2,
                       align: TextAlign.center
                     ),
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
            userName = snapshot.data;
          }
            return SafeArea(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      height: size.height * 0.65,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40.0),
                              bottomRight: Radius.circular(40.0),
                          ),
                          gradient: LinearGradient(
                            begin: FractionalOffset.topLeft,
                            end: FractionalOffset.bottomRight,
                            colors: [
                              Color(0xff4182db),
                              Color(0xff98dad1),
                            ],
                            stops: [
                              0.01, 1.0
                            ],
                          )
                      ),

                    child: Column(
                      children:
                      [
                        Container(
                          height: size.height * 0.1,
                          margin: EdgeInsets.only(left: 30, top:  size.height * 0.05, bottom: size.height * 0.03),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                            [
                              Row(
                                children: [
                                  Frame.myText(
                                      text: '$userName',
                                      fontSize: 2.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      align: TextAlign.start
                                  ),
                                  Frame.myText(
                                      text: ' 님,',
                                      fontSize: 1.5,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      align: TextAlign.start
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),

                              Frame.myText(
                                  text: '오늘도 즐거운 하루 보내세요!',
                                  fontSize: 1.5,
                                  color: Colors.white,
                                  align: TextAlign.start
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    buildMenuBtn('검사하기'),
                                    buildMenuBtn('검사 내역'),
                                  ],
                                ),
                                Row(
                                  children:
                                  [
                                    buildMenuBtn('성분 분석'),
                                    buildMenuBtn('나의 추이'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
          ),

                    /// 24.01.10
                    /// TODO: 이지미 필터로 인해 화면 이동후 버벅거림 현상이 있씀
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 50),
                            width: double.infinity,
                            child: ColorFiltered(
                              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.35), BlendMode.darken),
                              child: Image.asset('images/home_bottom.png', fit: BoxFit.fitWidth,),
                            ),
                          ),
                          Positioned(
                            bottom: 40,
                            left: 40,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Frame.myText(
                                  text:'당신의 건강한 삶에 함께 하는',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                Row(
                                  children: [
                                    Frame.myText(
                                      text:'YO',
                                      color: Colors.redAccent,
                                      fontSize: 1.7,
                                      fontWeight: FontWeight.bold
                                    ),
                                    Frame.myText(
                                        text:'CHECK',
                                        color: Colors.white,
                                        fontSize: 1.7,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
        },
      ),
    );
  }

  buildMenuBtn(String text) {
    return Expanded(
      child: InkWell(
        onTap: () async {
          if(text == '검사하기') {
            bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();

            if(!isLocationEnabled){
              CustomDialog.showMyDialog('위치정보', '휴대폰의 위치정보를 켜주시기 바랍니다.', context, false);
            }
            else {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context){
                    return StatefulBuilder(
                        builder: (BuildContext context, Function(void Function()) sheetSetState) {
                          return PreparationBottomSheet(
                              size: size,
                              onBackCallbackResult: (urineModel) =>_showResult(urineModel)
                          );
                        }
                    );
                  }
              );
            }

          } else if(text == '검사 내역'){
            Frame.doPagePush(context, ResultListPage());
          } else if(text == '나의 건강 관리'){
            //Frame.doPagePush(context, HealthCarePage());
            Frame.doPagePush(context, MyHealthPage());
          } else if(text == '나의 추이'){
            Frame.doPagePush(context, ChartPage());
          } else if(text == '성분 분석') {
            _fetchAIAnalyze();
          }
        },
        child: Container(
          height: size.height * 0.22,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children:
              [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('images/${Etc.buttonImageSwitch(text)}'),
                  ),
                ),

                SizedBox(
                  height: size.height * 0.05,
                  child: Frame.myText(
                      text: text,
                      fontSize: 1.3,
                      align: TextAlign.center),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  /// 성분 분석: 측정된 소변데이터로
  /// 한밭대학교에서 제공해주는 API 연동
  _fetchAIAnalyze() async  {
    CustomDialog.showAIDialog(
      '성분 분석',
      '제공되는 데이터는 참고 용도로만 사용되어야 하며, 전문가와의 상담을 권장합니다.',
      context,
      false
    );

    Future.delayed(Duration(seconds: 2), () async {
      try {
        List<Recent> resultList = await client.dioRecent('');

        Map<String, dynamic> toMap = {
          "blood": resultList[0].status == '0' ? "-" : "${resultList[0]
              .status}+",
          "bilirubin": resultList[1].status == '0' ? "-" : "${resultList[1]
              .status}+",
          "urobilinogen": resultList[2].status == '0' ? "-" : "${resultList[2]
              .status}+",
          "ketones": resultList[3].status == '0' ? "-" : "${resultList[3]
              .status}+",
          "protein": resultList[4].status == '0' ? "-" : "${resultList[4]
              .status}+",
          "nitrite": resultList[5].status == '0' ? "-" : "${resultList[5]
              .status}+",
          "glucose": resultList[6].status == '0' ? "-" : "${resultList[6]
              .status}+",
          "leukocytes": resultList[9].status == '0' ? "-" : "${resultList[9]
              .status}+",
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
        mLog.d('성분분석 : ${e}');
        Navigator.pop(context);
        CustomDialog.showMyDialog(
            '성분 분석', '정상적으로 처리 되지 않았습니다.\n다시 시도 해주세요.', context, false);
      }
    });
  }

  _fetchUserName() async {
    String userName =  await client.dioUserName();
    if(userName.length == 3){
      Authorization().name = userName;
      return userName;
    } else {
      return '-';
    }
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


  /**
   * 휴대폰 위치 정보가 on/off 인지 확인한다.
   */
  _checkPermission() async {
    await Permission.location.request();
    await Permission.bluetooth.request();
    await Permission.locationWhenInUse.request();
  }
  Future<void> requestLocationPermission() async {
    var status = await Permission.locationWhenInUse.status;
    if (!status.isGranted) {
      await Permission.locationWhenInUse.request();
    }
  }
}


