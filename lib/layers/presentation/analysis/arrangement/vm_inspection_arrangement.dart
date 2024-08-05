
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:urine/common/dart/kotlin_style/function_invokes.dart';
import 'package:urine/common/util/snackbar_utils.dart';

import '../../../../common/util/nav.dart';
import '../bluetooth/v_bluetooth_connection.dart';

class InspectionArrangementViewModel extends ChangeNotifier{

  InspectionArrangementViewModel(){
    checkPermission();
    addBluetoothStateLister();
  }

  /// 휴대폰 블루투스 on/off 상태
  bool _isBluetoothActive = false;

  /// 검사기 전원 블루투스 on/off 상태
  bool _isDeviceActive = false;

  /// 검사진행버튼 visible
  bool _visibleStartButton = false;

  /// Current state of the Bluetooth module Subscription
  late StreamSubscription<BluetoothAdapterState> adapterStateSubscription;

  /// 검사진행버튼 화면 하단에 보여주기 딜레이 시간(초)
  final int delayedSeconds = 3;

  bool get isBluetoothActive => _isBluetoothActive;
  bool get isDeviceActive => _isDeviceActive;
  bool get visibleStartButton => _visibleStartButton;


  /// 디바이스 전원 체크박스 변경 이벤트
  onChangedDevice(BuildContext context) {
    _isDeviceActive = !_isDeviceActive;

    // 24.07.27 - 검사기 전원 on/off 상태에 따라 검사진행버튼 화면 하단에 보여주기 자동으로 전환
    // 블루투스, 검사기 모두 ON일때 검사진행버튼 화면 하단에 보여주기
    //_visibleStartButton = _isBluetoothActive && _isDeviceActive;
    if(_isBluetoothActive && _isDeviceActive) {
      SnackBarUtils.showPrimarySnackBar(context,
          '잠시 후 검사를 진행합니다',
          seconds: delayedSeconds,
      );
      Future.delayed(delayedSeconds.seconds, (){
        Nav.doPop(context); // 검사전 준비 화면 pop
        Nav.doPush(context, const BluetoothConnectionView());
      });
    }
    notifyListeners();
  }


  /// 휴대폰 위치 정보가 on/off 인지 확인한다.
  void checkPermission() async {
    await Permission.location.request();
    await Permission.bluetooth.request();
    await Permission.locationWhenInUse.request();
  }


  /// 시스템 블루투스 on/off 상태 리스너
  void addBluetoothStateLister(){
    adapterStateSubscription = FlutterBluePlus.adapterState.listen((value){
      if (value == BluetoothAdapterState.off) {
        _isBluetoothActive = false;
      }
      else if(value == BluetoothAdapterState.on){
        _isBluetoothActive = true;
      } else {
        _isBluetoothActive = false;
      }
      notifyListeners();
    });
  }


  @override
  void dispose() {
    adapterStateSubscription.cancel();
    super.dispose();
  }
}