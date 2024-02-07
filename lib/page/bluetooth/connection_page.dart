
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:urine/utils/etc.dart';

import '../../main.dart';
import '../../model/bluetooth_ble.dart';
import '../../utils/color.dart';
import '../../utils/constants.dart';
import '../../providers/count_provider.dart';
import '../../utils/frame.dart';
import '../../widgets/button.dart';


/// 디바이스와 연결
class ConnectionPage extends StatefulWidget {
  final BluetoothDevice? device;

  const ConnectionPage({Key? key, required this.device}) : super(key: key);

  @override
  State<ConnectionPage> createState() => _ConnectionPateState();
}

class _ConnectionPateState extends State<ConnectionPage> with SingleTickerProviderStateMixin {

  late String connectionState;
  late String connectionButtonText ;
  late bool isConnection;
  late bool isShowButton ;
  late bool isLoading ;

  bool isWrite = false;
  bool isNotification = false;
  bool isRunOnce = true;

  late CountProvider _countProvider;
  late AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _configureInitView();

    _bluetoothDeviceConnectionLister(widget.device!); // 디바이스 연결 상태 리스너 등록
    _bluetoothConnectionStart();

    controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )
      ..forward()
      ..addListener(() {
        if (controller.isCompleted) {
          controller.repeat();
        }
      });
  }

  _configureInitView() {
    connectionState = '유린검사기와 연결중입니다.';
    connectionButtonText = '';
    isConnection = false;
    isShowButton = false;
    isLoading = true;
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  /// convert 0-1 to 0-1-0
  double shake(double value) => 2 * (0.5 - (0.5 - Curves.bounceOut.transform(value)).abs());

  @override
  Widget build(BuildContext context) {
    _countProvider = Provider.of<CountProvider>(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 100, bottom: 80),
          child: isConnection ?
          AnimatedBuilder(
              builder: (BuildContext context, Widget? child) =>
                  Transform.translate(child: child, offset: Offset(0, 20 * shake(controller.value))),
              animation: controller,
              child: Image.asset('images/link.png', height: 130, width: 130,)
          ) :
          isLoading ?
          SpinKitCircle(
              size: 100,
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                    decoration: BoxDecoration(
                      color: index.isEven ? mainColor : Colors.white,
                    )
                );
              }
          ) :
          AnimatedBuilder(
              builder: (BuildContext context, Widget? child) =>
                  Transform.translate(child: child, offset: Offset(0, 20 * shake(controller.value))),
              animation: controller,
              child: Image.asset('images/error.png', height: 130, width: 130,)
          ),
        ),

        Frame.myText(
            text: connectionState,
            maxLinesCount: 2,
            color: isConnection ? Colors.black : Colors.grey,
            fontSize: 1.2,
            fontWeight: FontWeight.w600,
            align: TextAlign.center
        ),

        SizedBox(height: 20),

        Visibility(
            visible: isShowButton,
            child: ConnectionToInspectionButton(
                text: isConnection? '검사 진행' : '재 연결',
              reconnectFunction: () => _reconnect(),
            )
        )
      ],
    );
  }

  _bluetoothConnectionStart() {
    widget.device!.connect(autoConnect: false).timeout(Duration(seconds: 6), onTimeout: ()=>{
      setState((){
        connectionState = '기기와 연결하지 못했습니다.\n 다시 시도 하시겠습니까?';
        isConnection = false;
        isShowButton = true;
        isLoading = false;
      })
    });
  }

  /// 선택된 디바이스 연결 상태 리스너
  _bluetoothDeviceConnectionLister(BluetoothDevice device){
    device.state.listen((value){
      switch (value) {
        case BluetoothConnectionState.connected: {
          mLog.i('BluetoothDeviceState.connected : connected');
          _bluetoothGattServiceLister(device);

          break;
        }
        case BluetoothConnectionState.disconnected: {
          mLog.i('BluetoothDeviceState.connected : disconnected');
          break;
        }
        default: {
          connectionState = '${value.toString().substring(21).toUpperCase()}';
          isConnection = false;
          mLog.d('BluetoothDeviceState.connected : ${value.toString().substring(21).toUpperCase()}');
          break;
        }
      }
    });
  }

   _bluetoothGattServiceLister(BluetoothDevice device) {
    device.discoverServices();

    print("_bluetoothGattServiceLister ${device.id} 실행");
    //80:EA:CA:91:B2:2A

    device.services.listen((List<BluetoothService> gattService) {
      //if(isRunOnce) {
      //  isRunOnce = false;
      if(gattService.length > 0)
      {
        /// Gatt Service 찾기
        BluetoothService? bluetoothService = Etc.findBluetoothService(gattService);
        if(bluetoothService == null){
          mLog.i('gattService 를 찾지 못했습니다.');
        } else {
          /// notificationCharacteristic 찾기
          final notificationCharacteristic =
          Etc.findBluetoothCharacteristic(bluetoothService, BLE_GATT_UUID_NOTIFICATION)!;

          /// writeCharacteristic 찾기
          final writeCharacteristic =
          Etc.findBluetoothCharacteristic(bluetoothService, BLE_GATT_UUID_WRITE)!;
          if(isRunOnce) {
           isRunOnce = false;

            isWrite = true;
            isNotification = true;
            isLoading = false;
            mLog.i('isRunOnce 실행');
            _setNotification(notificationCharacteristic, writeCharacteristic);
            }
        }
      }

      });
  }

  // BluetoothService? findBluetoothService(List<BluetoothService> gattService){
  //   BluetoothService? applicableService;
  //
  //   for(var service in gattService) {
  //     if(service.uuid.toString() == BLE_GATT_UUID_GATT_SERVICE){
  //       applicableService = service;
  //     }
  //   }
  //   return applicableService;
  // }
  //
  // BluetoothCharacteristic? findBluetoothCharacteristic(BluetoothService gattService, String findCharacteristic){
  //   BluetoothCharacteristic? applicableCharacteristics;
  //
  //   for(var characteristics in gattService.characteristics) {
  //     if(characteristics.uuid.toString() == findCharacteristic){
  //       applicableCharacteristics = characteristics;
  //     }
  //   }
  //
  //   return applicableCharacteristics;
  // }

  _setNotification(BluetoothCharacteristic notificationCharacteristic, BluetoothCharacteristic writeCharacteristic) async {

    mLog.i('notificationCharacteristic: ${notificationCharacteristic.uuid}');
    try {
      bool? isNotifyValue = await notificationCharacteristic.setNotifyValue(true);
      mLog.i('isNotifyValue : ${isNotifyValue}');
    } catch (e, s) {
      print(s);
    }

    if(isNotification && isWrite) {
      mLog.i('검사할 준비가 다 되었습니다.');
      _countProvider.setCharacteristicNotification(notificationCharacteristic);
      _countProvider.setCharacteristicWrite(writeCharacteristic);

      setState((){
        connectionState = '연결이 완료 되었습니다.\n 검사 진행하시겠습니까?';
        isConnection = true;
        isShowButton = true;
      });
    } else {
      mLog.d('아직 준비가 되지 않았습니다. : ${isNotification} / ${isWrite}');
    }
  }

  /// 재연결
  _reconnect() {
    _configureInitView();
    _bluetoothConnectionStart();
  }
}
