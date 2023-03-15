
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:provider/provider.dart';
import 'package:urine/model/authorization.dart';
import 'package:urine/model/urine_model.dart';
import 'package:urine/page/bluetooth/search_device_page2.dart';
import 'package:urine/page/progress_page.dart';
import 'package:urine/page/result_list_page.dart';
import 'package:urine/page/setting/setting_page.dart';
import 'package:urine/providers/bluetooth_state_provider.dart';
import 'package:urine/utils/constants.dart';
import 'package:urine/utils/dio_client.dart';
import 'package:urine/utils/etc.dart';
import 'package:urine/widgets/bottom_sheet.dart';

import '../main.dart';
import '../model/recent.dart';
import '../utils/color.dart';
import '../utils/frame.dart';
import '../utils/network_connectivity.dart';
import 'ai_result_page.dart';
import 'bluetooth/bluetooth_controller.dart';
import 'health_care_page.dart';

/// Devices Name :
class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  final String title = '홈 화면';

  late AnimationController animationController;
  late BluetoothStateProvider _bluetoothStateProvider;
  late Size size;

  var userName = '-';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    animationController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )
      ..forward()
      ..addListener(() {
        if (animationController.isCompleted) {
          animationController.repeat();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    /// 네트워크 연결 상태 확인
    NetWorkConnectivity(context: context);

    _bluetoothStateProvider = Provider.of<BluetoothStateProvider>(context);
    BluetoothController().bluetoothStateProvider =  _bluetoothStateProvider;
    BluetoothController().context =  context;
    BluetoothController().animationController =  animationController;
    BluetoothController().size =  size;


    return Scaffold(
      backgroundColor: homeBackgroundColor,
      appBar: Frame.myAppbar(
          title,
          isIconBtn: true,
          onPressed: () {
             Frame.doPagePush(context, SettingPage());
          }
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
                       text: '서버와 연결이 원활하지 않습니다.\n 다시 시도 바랍니다.',
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
            return Container(
            child: Column(
              children: [
                Container(
                  height: 100,
                  margin: EdgeInsets.only(left: 30, top: 80),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      Frame.myText(text: '$userName 님', fontSize: 1.7, color: mainColor, fontWeight: FontWeight.w600, align: TextAlign.start),
                      Frame.myText(text: '오늘도 즐거운 하루 되세요.', fontSize: 1.3, align: TextAlign.start)
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
                            buildMenuBtn('검사하기',  '1'),
                            buildMenuBtn('검사 내역', '2'),
                          ],
                        ),
                        Row(
                          children:
                          [
                            buildMenuBtn('AI 분석', '3'),
                            buildMenuBtn('나의 건강 관리', '4'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Expanded buildMenuBtn(String text, String imageName) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if(text == '검사하기'){

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

            /*Frame.doPagePush(context, SearchDevicePage2(onBackCallbackResult: (urineModel) {
              showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context){

                    return StatefulBuilder(
                        builder: (BuildContext context, Function(void Function()) sheetSetState) {
                          return FastestBottomSheet(urineModel: urineModel, size: size);
                        });}
              );
            },));*/



            // FlutterBluePlus.instance.connectedDevices.then((connectedDeviceList){
            //   if(connectedDeviceList.length > 0) {
            //
            //     BluetoothController().showConnectionDialog(
            //         title: '연결 상태',
            //         content: '유린기와 연결되어 있습니다. 바로 검사를 진행하시겠습니까?',
            //         mainContext: context,
            //         controller: animationController
            //     );
            //   }
            //   else {
            //     if(BluetoothController().writeCharacteristic != null){
            //       BluetoothController().instanceClean();
            //     }

            //   }
            // });
          } else if(text == '검사 내역'){
            Frame.doPagePush(context, ResultListPage());
          } else if(text == '나의 건강 관리'){
            Frame.doPagePush(context, HealthCarePage());
          } else if(text == 'AI 분석') {
            _fetchAIAnalyze();

          }
        },
        child: Container(
          height: 180,
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('images/main_image_$imageName.png'),
                  ),
                ),

                Expanded(
                  flex: 1,
                  child: Frame.myText(
                      text: text,
                      fontSize: 1.2,
                      fontWeight: FontWeight.w600,
                      align: TextAlign.center),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  /// AI 분석: 측정된 소변데이터로
  /// 한밭대학교에서 제공해주는 API 연동
  _fetchAIAnalyze() async {
    Navigator.of(context).push(ProgressPage(InspectionType.ai));
    List<Recent> resultList = await client.dioRecent('');

    Map<String, dynamic> toMap = {
      "blood": int.parse(resultList[0].status),
      "bilirubin": int.parse(resultList[1].status),
      "urobilinogen": int.parse(resultList[2].status),
      "ketones": int.parse(resultList[3].status),
      "protein": int.parse(resultList[4].status),
      "nitrite": int.parse(resultList[5].status),
      "glucose": int.parse(resultList[6].status),
      "ph": int.parse(resultList[7].status),
      "sg": int.parse(resultList[8].status),
      "leukocytes": int.parse(resultList[9].status),
    };

//UrineModel{blood: 2, billrubin: 0, urobillnogen: 0, ketones: 0, protein: 2, nitrite: 0, glucose: 0, pH: 2, sG: 2, leucoytes: 0, vitamin: 1}
    String result = await client.dioAI(toMap);

    if(result != 'ERROR' ||  result != 'unknown') {
      mLog.i('[AI result]: $result');
    }
    Future.delayed(Duration(seconds: 3),() {
      Navigator.pop(context);
      Frame.doPagePush(context, AIResultPage(result: result));
      mLog.i('[AI result]: $result 증상이 나왔습니다.');
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

  void _showResult(UrineModel urineModel) {
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
}
