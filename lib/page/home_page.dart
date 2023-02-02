
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:urine/model/authorization.dart';
import 'package:urine/page/find_devices_page.dart';
import 'package:urine/page/setting/setting_page.dart';
import 'package:urine/utils/constants.dart';
import 'package:urine/utils/etc.dart';
import 'package:urine/widgets/bottom_sheet.dart';
import 'package:urine/widgets/dialog.dart';

import '../main.dart';
import '../model/urine_model.dart';
import '../utils/color.dart';
import '../utils/frame.dart';
import '../utils/network_connectivity.dart';

/// Devices Name :
class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final String title = '홈 화면';
  late BluetoothCharacteristic characteristicWrite;

  bool isBluetoothState = false;

  bool isNotification = false;
  bool isWrite = false;

  StringBuffer sb = new StringBuffer('');

  bool runOnce = true;

  late BluetoothCharacteristic characteristicNotification;

  bool isConnectionStatus = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _bluetoothStateLister();
  }


  @override
  Widget build(BuildContext context) {

    /// 네트워크 연결 상태 확인
    NetWorkConnectivity(context: context);

    return Scaffold(
      backgroundColor: homeBackgroundColor,
      appBar: Frame.myAppbar(
          title,
          isIconBtn: true,
          onPressed: ()
          {
           Frame.doPagePush(context, SettingPage());
          }
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 100,
              margin: EdgeInsets.only(left: 30, top: 40),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  Frame.myText(text: '---님', fontSize: 1.7, color: mainColor, fontWeight: FontWeight.w600, align: TextAlign.start),
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
                        buildMenuBtn('최근 검사결과', '2'),
                      ],
                    ),
                    Row(
                      children: [
                        buildMenuBtn('검사내역', '3'),
                        buildMenuBtn('결과 내역 추이', '4'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildMenuBtn(String text, String imageName) {
    return Expanded(
      child: InkWell(
        onTap: (){

          // 블루투스가 OFF 일때
          if(!isBluetoothState){
            CustomDialog.showMenuDialog(context, height: 140);
            return;
          }

          // 디바이스와 연결이 되어 있을 때
          if(isConnectionStatus){
            sb.clear(); // 재검사 시 clear
            showActionDialog('연결 완료', '검사 진행 하시겠습니까?', context);
            return;
          }

          if(Authorization().address == ''){
            // 찾는 화면으로 이동
            Frame.doPagePush(context, FindDevicesPage(onBackCallbackConnect: (device) => {
              device.connect(autoConnect: false),
              _bluetoothDeviceConnectionLister(device) // 디바이스 연결 상태 리스너 등록
            } ));
          } else {
            mLog.d("Authorization().address 여기 실행");
            BluetoothDevice.fromId(Authorization().address).connect(autoConnect: false); // 디바이스 찾기 화면 없이 바로 연결
          }

          // if(text == '최근 검사결과')
          //   Frame.doPagePush(context, RecentPage(title: '최근 검사 결과'));
          // else if(text == '검사내역'){
          //   Frame.doPagePush(context, ResultListPage());
          // }else if(text == '결과 내역 추이'){
          //   Frame.doPagePush(context, ChartPage());
          // }
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

  // /// 홈 화면으로 넘어 왔을때 블루투스 연결
  // _onBackCallbackConnect(BluetoothDevice device)  {
  //   // BluetoothDevice.fromId('asdasd').connect();
  //
  //   device.connect(); // 연결 시도
  //
  //   _bluetoothDeviceConnectionLister(device); // 디바이스 연결 상태 확인
  // }


  /// 선택된 디바이스 연결 상태 리스너
  _bluetoothDeviceConnectionLister(BluetoothDevice device){
    device.state.listen((value){
      switch (value) {
        case BluetoothDeviceState.connected:{
          mLog.i('BluetoothDeviceState.connected : connected');
          isConnectionStatus = true;
          // Gatt Service 찾기
          _bluetoothGattServiceLister(device);
          break;
        }
        case BluetoothDeviceState.disconnected:
          mLog.i('BluetoothDeviceState.connected : disconnected');
          isConnectionStatus = false;
          break;
        default:
          mLog.d('BluetoothDeviceState.connected : ${value.toString().substring(21).toUpperCase()}');
          break;
      }
    });
  }

  /// 시스템 블루투스 on/off 상태 리스너
  _bluetoothStateLister(){
    FlutterBluePlus.instance.state.listen((value){

      if (value == BluetoothState.off) {
        isBluetoothState = false;
        CustomDialog.showMenuDialog(context, height: 140);
      }
      else if( value == BluetoothState.on){
        isBluetoothState = true;
      }
    });
  }

  _setNotification(BluetoothCharacteristic characteristicNotification) async{
    await characteristicNotification.setNotifyValue(!characteristicNotification.isNotifying);

    if(isNotification && isWrite){
      /// onValueChangedStreamListener();

      mLog.i('검사할 준비가 다 되었습니다.');
      showActionDialog('연결 완료', '검사 진행 하시겠습니까?', context);

    } else {
      mLog.d('아직 준비가 되지 않았습니다. : ${isNotification} / ${isWrite}');
    }
  }

  void _bluetoothGattServiceLister(BluetoothDevice device) {
    device.discoverServices();

    print("_bluetoothGattServiceLister ${device.id} 실행");
    //80:EA:CA:91:B2:2A

    device.services.listen((gattService) {
      print("device.services.listen 실헹");
      for(var service in gattService) {
        print("Found service ${service.uuid}");
        if(service.uuid.toString() == '0783b03e-8535-b5a0-7140-a304d2495cb7'){
          for( var characteristic in service.characteristics) {
            print("${characteristic.uuid}");

            if(characteristic.uuid.toString() == '0783b03e-8535-b5a0-7140-a304d2495cb8')
            {
              mLog.i('notification uuid : 0783b03e-8535-b5a0-7140-a304d2495cb8 있다.');
              characteristicNotification = characteristic;

              if(runOnce) {
                runOnce = false;
                _setNotification(characteristic);
              }

              isNotification = true;
            }

            if(characteristic.uuid.toString() == '0783b03e-8535-b5a0-7140-a304d2495cba')
            {
              mLog.i('write uuid : 0783b03e-8535-b5a0-7140-a304d2495cba 있다.');
              characteristicWrite = characteristic;
              isWrite = true;
            }
          }
        }
      }
    });
  }


  void _startInspection() async {
    await characteristicWrite.write(Etc.hexStringToByteArray('2554530a'), withoutResponse: true);
  }

  /// 다이얼 로그
   showActionDialog(String title, String text, BuildContext mainContext) {
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
                      onValueChangedStreamListener();
                      _startInspection();
                      Navigator.pop(context);
                    },
                    child: Text('확인', textScaleFactor: 1.0, style: TextStyle(color: Colors.white))
                ),
              ),

            ],
          );
        });
  }


  /// characteristic 상태 변화
  /// 데이터 리스너 메소드
  void onValueChangedStreamListener() {
    mLog.i(characteristicNotification.serviceUuid);

    if(characteristicNotification.uuid.toString() == BLE_GATT_UUID_NOTIFICATION) {
      characteristicNotification.onValueChangedStream.listen((value) {
        // 버퍼에 수신된 데이터를 쌓는다.
        sb.write((String.fromCharCodes(value)).replaceAll('\n', ''));

        // 마지막 비타민 결과 데이터가 들어왔는지 확인한다.
        // 이후 파싱
        if (sb.toString().contains('#A11')) {
          mLog.d('replaceAll: ${sb.toString().replaceAll('\n', '')}');
          UrineModel urineModel = UrineModel();
          urineModel.initialization(sb.toString());
          urineModel.toString();
          mLog.d(urineModel.vitamin);

          // showModalBottomSheet(
          //     isScrollControlled: true,
          //     context: context,
          //     builder: (BuildContext context){
          //       return StatefulBuilder(
          //           builder: (BuildContext context, Function(void Function()) sheetSetState) {
          //             return FastestBottomSheet(urineModel: urineModel);
          //           });}
          // );
        };
      });
    } else {
      mLog.d('NOT BLE_GATT_UUID_NOTIFICATION');
    }

  }
}
