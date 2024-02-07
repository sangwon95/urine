
import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../model/urine_model.dart';

class CountProvider extends ChangeNotifier {

  int _count = 0;
  BluetoothDevice? _device;
  BluetoothCharacteristic? _notificationCharacteristic;
  BluetoothCharacteristic? _writeCharacteristic;
  UrineModel? _urineModel;

  int get count => _count;
  BluetoothDevice? get device => _device;
  BluetoothCharacteristic? get notificationCharacteristic =>_notificationCharacteristic;
  BluetoothCharacteristic? get writeCharacteristic =>_writeCharacteristic;
  UrineModel? get urineModel => _urineModel;


  increase() {
    _count++;
    notifyListeners();
  }

  setDevice(BluetoothDevice device) {
    _device = device;
    notifyListeners();
  }

  setCharacteristicNotification(BluetoothCharacteristic characteristic){
    _notificationCharacteristic = characteristic;
    notifyListeners();
  }

  setCharacteristicWrite(BluetoothCharacteristic characteristic){
    _writeCharacteristic = characteristic;
    notifyListeners();
  }

  setUrineModel(UrineModel urineModel){
    _urineModel = urineModel;
    notifyListeners();
  }

  clean() {
    _count = 0;
    //notifyListeners();
  }

  /// 연결이 되어 있어 바로 검사 할 수 있는 화면으로 초기화
  connected() {
    _count = 3;
    //notifyListeners();
  }
}