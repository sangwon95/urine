
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../utils/color.dart';
import '../../utils/count_provider.dart';
import '../../utils/frame.dart';
import '../../widgets/button.dart';

/// 기기 찾기
class SearchDevicePage extends StatefulWidget {
  const SearchDevicePage({Key? key}) : super(key: key);

  @override
  State<SearchDevicePage> createState() => _SearchDevicePageState();
}

class _SearchDevicePageState extends State<SearchDevicePage> {

  /// step 1: 기기 찾기
  late bool isShowGlows; // 디바이스 찾기 파동 애니메이션
  late bool isDeviceFound;
  late String deviceFoundState;
  late bool isVisibleConnectionButton;
  late String connectionButtonText;

  late BluetoothDevice device;
  late CountProvider _countProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _configureInitView(); // 초기 화면 구성
    _bluetoothScanResultsLister(); // 블루투스 스캔 리스너 등록
    _bluetoothScanStart();
  }

  _configureInitView() {
    isShowGlows = true; // 디바이스 찾기 파동 애니메이션
    isDeviceFound = false;
    deviceFoundState = '유린검사기를 찾고있습니다.\n잠시만 기달려주세요.';
    isVisibleConnectionButton = false;
    connectionButtonText = '';
  }


  @override
  Widget build(BuildContext context) {
    _countProvider = Provider.of<CountProvider>(context);

    mLog.i('검색 화면 재빌드: $isShowGlows');

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 30, 15, 15),
          child: AvatarGlow(
            glowColor: mainColor,
            endRadius: 130.0,
            duration: Duration(milliseconds: 2000),
            repeat: isShowGlows,
            showTwoGlows: isShowGlows,
            animate: isShowGlows,
            repeatPauseDuration: Duration(milliseconds: 200),
            child: Material(     // Replace this child with your own
              elevation: 4.0,
              shape: CircleBorder(),
              child: CircleAvatar(
                backgroundColor: Colors.grey[100],
                child: isDeviceFound ?
                Icon(Icons.check, color: Colors.blue, size: 50) :
                connectionButtonText == '재 시도' ?
                Icon(Icons.question_mark, color: Colors.blue, size: 50) :
                Icon(Icons.bluetooth, color: Colors.blue, size: 50),
                radius: 45.0,
              ),
            ),
          ),
        ),

        Frame.myText(
            text: deviceFoundState,
            maxLinesCount: 2,
            fontSize: 1.2,
            fontWeight: FontWeight.w600,
            align: TextAlign.center
        ),

        SizedBox(height: 20),

        Visibility(
            visible: !isShowGlows, // 파동을 없애는 동시에 버튼 생성
            child: SearchToConnectionButton(
              text: connectionButtonText,
              againSearchFunction: () => _againSearch(),
            )
        )
      ],
    );
  }

  /// 디바이스 찾기 결과 리스너
  _bluetoothScanResultsLister() {
    // Listen to scan results
    FlutterBluePlus.instance.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
        if(r.device.name == 'PhotoMT91b22a'){
          FlutterBluePlus.instance.stopScan();
          Future.delayed(Duration(seconds: 4), (){
            if(mounted){
              setState(() {
                isDeviceFound = true;
                isShowGlows = false;
                connectionButtonText = '연결';
                deviceFoundState = '유린검사기를 찾았습니다.\n연결 하시겠습니까?';
                _countProvider.setDevice(r.device);
              });
            }
          });
          return;
        }
      }
    });
  }

  /// 스켄 시작
  _bluetoothScanStart(){
    // Start scanning
    FlutterBluePlus.instance.startScan(timeout: const Duration(seconds: 4));

    Future.delayed(Duration(seconds: 5), (){
      // 유린기를 찾지 못했을 경우 재시도 버튼 생성
      if(!isDeviceFound){
        setState(() {
          mLog.i("디바이스를 찾지 못했습니다.");
          isShowGlows = false;
          deviceFoundState = '유린검사기를 찾지 못했습니다.\n재시도 하시겠습니까?';
          connectionButtonText = '재 시도';

          FlutterBluePlus.instance.stopScan();
        });
      }
    });
  }

  /// 디바이스 재 검색
  _againSearch(){
    if(mounted){
      setState(() {
        _configureInitView(); // view 초기화
        _bluetoothScanStart(); // 블루투스 검색 재시작
      });
    }
  }

}
