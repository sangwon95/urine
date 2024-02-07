import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:urine/model/authorization.dart';
import 'package:urine/model/raw_insert_data.dart';
import 'package:urine/utils/dio_client.dart';

import '../../main.dart';
import '../../model/urine_model.dart';
import '../../providers/bluetooth_state_provider.dart';
import '../../utils/color.dart';
import '../../utils/constants.dart';
import '../../utils/etc.dart';
import '../../widgets/bottom_sheet.dart';
import '../progress_page.dart';

class BluetoothController{
  /// 한번 초기화로 계속 사용할 수 있다.
  static final BluetoothController _authInstance = BluetoothController.internal();

  /// 첫 화면(HomePage)에서 초기화 한다.
  late BluetoothStateProvider bluetoothStateProvider;
  late BuildContext context;
  late AnimationController animationController;
  late Size size;

  BluetoothCharacteristic? notificationCharacteristic = null;
  BluetoothCharacteristic? writeCharacteristic = null;

  late bool isNotifyValue;
  StreamSubscription<List<BluetoothService>>? serviceLister = null;
  StreamSubscription<BluetoothDeviceState>? connectionLister = null;
  StreamSubscription<List<int>>? onValueChangedStream = null;

  StringBuffer sb = new StringBuffer('');

  bool isNoResponse = true;
  late BluetoothDevice mDevice;

  /// 검사 진행중에는 추가적으로 검사 진행 할 수 없다.
  //bool isWriting = true;

  factory BluetoothController(){
    return _authInstance;
  }

  BluetoothController.internal() {
    _addBluetoothStateLister();
  }

  instanceClean(){
    serviceLister?.cancel();
    connectionLister?.cancel();
    onValueChangedStream?.cancel();

    sb.clear();
    isNoResponse = true;
    notificationCharacteristic = null;
    writeCharacteristic = null;

    isNotifyValue = false;
    serviceLister = null;
    connectionLister = null;
    onValueChangedStream = null;
    mDevice.disconnect();
  }

  /// 시스템 블루투스 on/off 상태 리스너
  _addBluetoothStateLister(){
    FlutterBluePlus.adapterState.listen((value){
      if (value == BluetoothState.off) {
        bluetoothStateProvider.setStateOff();
      }
      else if(value == BluetoothState.on){
        bluetoothStateProvider.setStateOn();
      } else {
        mLog.i('${value.toString()}');
      }
    });
  }

  /// 선택된 디바이스 연결 상태 리스너
  // addBluetoothDeviceConnectionLister(BluetoothDevice device){
  //   this.mDevice = device;
  //   connectionLister = mDevice.connectionState.listen((value){
  //     switch (value) {
  //       case BluetoothConnectionState.connected: {
  //         mLog.i('[BluetoothController/addBluetoothDeviceConnectionLister]: Connected!');
  //         /// Gatt Service 찾기
  //        if(serviceLister == null){ // 등록된 GattServiceLister 가 없으면 실행된다.
  //          addBluetoothGattServiceLister();
  //        } else {
  //          mLog.i('[BluetoothController/addBluetoothDeviceConnectionLister] serviceLister: 리스너가 등록 되어 있다.');
  //        }
  //         break;
  //       }
  //       case BluetoothDeviceState.disconnected:
  //         mLog.i('[BluetoothController/addBluetoothDeviceConnectionLister]: Disconnected!');
  //         break;
  //       default:
  //         mLog.d('BluetoothDeviceState.connected : ${value.toString().substring(21).toUpperCase()}');
  //         break;
  //     }
  //   });
  // }

  /// GattServiceLister 등록
  /// notification,write Characteristic 찾는다.
  addBluetoothGattServiceLister() {
    mDevice.discoverServices();
    mLog.i("[BluetoothController/addBluetoothGattServiceLister] device.id: ${mDevice.id} 실행");

    serviceLister = mDevice.services.listen((List<BluetoothService> gattService) {

      for(var value in gattService){
        mLog.i('gattService: ${value.uuid}');
        for(var characteristics in value.characteristics){
          mLog.i('characteristics: ${characteristics.uuid}');
        }
      }

      if(gattService.length > 0 && notificationCharacteristic == null && writeCharacteristic == null) {
        /// Gatt Service 찾기
        BluetoothService? bluetoothService = Etc.findBluetoothService(gattService);
        if(bluetoothService == null){
          mLog.i('gattService 를 찾지 못했습니다.');
        } else {
          /// notificationCharacteristic 찾기
          notificationCharacteristic =
          Etc.findBluetoothCharacteristic(bluetoothService, BLE_GATT_UUID_NOTIFICATION)!;

          /// writeCharacteristic 찾기
          writeCharacteristic =
          Etc.findBluetoothCharacteristic(bluetoothService, BLE_GATT_UUID_WRITE)!;

          _setNotification();
        }
      } else {
       mLog.i('notificationCharacteristic or writeCharacteristic not NULL');
      }
    });
  }

  /// 지정된 특성 값에 대한 알림 또는 표시를 설정합니다.
  _setNotification() async {
    if(notificationCharacteristic != null){
      mLog.i('[BluetoothController/_setNotification] notificationCharacteristic uuid: ${notificationCharacteristic!.uuid}');
      try {
        isNotifyValue = await notificationCharacteristic!.setNotifyValue(true);

        addValueChangedStreamListener();
        mLog.i('[BluetoothController] writeCharacteristic uuid: ${writeCharacteristic!.uuid}');
        showConnectionDialog(
              title: '연결 완료',
              content: '검사기와 연결이 완료되었습니다. 검사를 진행하시겠습니까?',
              mainContext: context,
              controller: animationController
        );

        mLog.i('[BluetoothController/_setNotification] isNotifyValue: $isNotifyValue');
      } catch (e) {
        mLog.i('[BluetoothController/_setNotification] notificationCharacteristic uuid: ${notificationCharacteristic!.uuid}');
        mLog.i('[BluetoothController/_setNotification] error: $e');
      }
    }
  }


  /// characteristic 상태 변화
  /// 데이터 리스너 메소드
  addValueChangedStreamListener() {
    if(notificationCharacteristic!.uuid.toString() == BLE_GATT_UUID_NOTIFICATION && onValueChangedStream == null) {
      onValueChangedStream = notificationCharacteristic!.onValueChangedStream.listen((value) {
        mLog.i('onValueChangedStream 실행');
        // 버퍼에 수신된 데이터를 쌓는다.
        sb.write((String.fromCharCodes(value)).replaceAll('\n', ''));

        // 마지막 비타민 결과 데이터가 들어왔는지 확인한다.
        // 이후 파싱
        if (sb.toString().contains('#A11')) {
          mLog.d('replaceAll: ${sb.toString().replaceAll('\n', '')}');
          //isWriting = true; // 검사 종료

          UrineModel urineModel = UrineModel();
          urineModel.initialization(sb.toString());
          mLog.i(urineModel.toString());

          /// 서버에 수집된 데이터 저장
          _saveResultData(urineModel);

          popProgress();
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context){

                return StatefulBuilder(
                    builder: (BuildContext context, Function(void Function()) sheetSetState) {
                      return FastestBottomSheet(urineModel: urineModel, size: size);
                    });}
          );
          isNoResponse = false;
          sb.clear();
        };
      });
    } else {
      mLog.d('NOT BLE_GATT_UUID_NOTIFICATION');
    }
  }

 Future<void> startInspection() async {
    if(writeCharacteristic != null){
      await writeCharacteristic!.write(Etc.hexStringToByteArray('2554530a'), withoutResponse: true);

      /// 소변 분석 Timeout
      /// write 후 9초동안 응답이 오지 않을 경우 Progress 화면을 종료 한다.
      Future.delayed(Duration(seconds: 9),(){
        mLog.i('startInspection() / popProgress() : ${sb.length}');
        if(isNoResponse){
          popProgress();
          showNoResponseDialog(
              title: '문제',
              content: '검사기로부터 데이터를 받지 못했습니다. 다시 시도바랍니다.',
              controller: animationController,
              mainContext: context
          );
          isNoResponse = true;
        }
      });
    } else {
      mLog.i('writeCharacteristic null!');
    }
  }


  showProgress(){
    Navigator.of(context).push(ProgressPage(InspectionType.basic));
  }

  popProgress(){
    Navigator.pop(context);
  }

  /// 연결 완료 popup
  showConnectionDialog({
    required String title,
    required String content,
    required BuildContext mainContext,
    required AnimationController controller
  }) {
    return showDialog(
        context: mainContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [
                Text(title, textScaleFactor: 0.9, style: TextStyle(fontWeight: FontWeight.bold, color: mainColor)),

                SizedBox(height: 20),

                AnimatedBuilder(
                    builder: (BuildContext context, Widget? child) =>
                        Transform.translate(
                            child: child,
                            offset: Offset(0, 20 * 2 * (0.5 - (0.5 - Curves.bounceOut.transform(controller.value)).abs()))),
                    animation: controller,
                    child: Image.asset('images/link.png', height: 80, width: 80,)
                ),
              ],
            ),
            content: SizedBox(
              height: 130,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                    child: SizedBox(
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: 220,
                              child: Text(content, textAlign: TextAlign.center, textScaleFactor: 0.85)),
                        ],
                      ),
                    ),
                  ),
                  //SizedBox(height: 15),

                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 45,
                            // width: (double.infinity / 2) - 2,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    elevation: 5.0,
                                    backgroundColor: mainColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10.0))
                                    )),
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
                            //width: (double.infinity / 2) - 2,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    elevation: 5.0,
                                    backgroundColor: mainColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(10.0),
                                        )
                                    )),
                                onPressed: () {
                                  startInspection();
                                  Navigator.pop(context);
                                  showProgress();
                                },
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
            contentPadding: EdgeInsets.all(0),
          );
        });
  }

  /// 검사 시작 후 무 응답일 경우
  showNoResponseDialog({
    required String title,
    required String content,
    required BuildContext mainContext,
    required AnimationController controller
  }) {
    return showDialog(
        context: mainContext,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [
                Text(title, textScaleFactor: 0.9,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: mainColor)),

                SizedBox(height: 20),

                AnimatedBuilder(
                    builder: (BuildContext context, Widget? child) =>
                        Transform.translate(
                            child: child,
                            offset: Offset(0, 20 * 2 * (0.5 -
                                (0.5 - Curves.bounceOut.transform(controller
                                    .value)).abs()))),
                    animation: controller,
                    child: Image.asset(
                      'images/error.png', height: 80, width: 80,)
                ),
              ],
            ),
            content: SizedBox(
              height: 130,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                    child: SizedBox(
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: 220,
                              child: Text(content, textAlign: TextAlign.center,
                                  textScaleFactor: 0.85)),
                        ],
                      ),
                    ),
                  ),
                  //SizedBox(height: 15),
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
                                    bottomLeft: Radius.circular(10.0),
                                  )
                              )),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('확인', textScaleFactor: 1.0,
                              style: TextStyle(color: Colors.white))
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  /// 검사 결과 데이터 저장
  _saveResultData(UrineModel urineModel) async {
    for(int i = 0 ; i < 11 ; i++){
      urineModel.dataMap.add(
          RawInsertData(
              Authorization().userID,
              urineModel.date,
              inspectionItemTypeList[i],
              urineModel.urineList[i] != '0' ? '양성' : '음성',
              urineModel.urineList[i]).toMap()
      );
    }

    UrineModel resultUrineModel = await client.dioSaveResultData(urineModel.dataMap);
    mLog.d('${resultUrineModel.code}/ ${resultUrineModel.message}');
    if(resultUrineModel.code == '200' && resultUrineModel.message == 'Success'){
      mLog.i('[UrineModel]: 최근 데이터 저장 완료!');
    } else {
      mLog.e('[UrineModel]: 최근 데이터 저장 실패!');
    }

  }
}