
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothBle{
  late BluetoothCharacteristic? writeCharacteristic;
  late BluetoothCharacteristic? notificationCharacteristic;


  /// 한번 초기화로 계속 사용할 수 있다.
  static final BluetoothBle _instance = BluetoothBle.internal();

  factory BluetoothBle(){
    return _instance;
  }

  BluetoothBle.internal() {
  }
}