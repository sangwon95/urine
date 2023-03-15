
import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:urine/main.dart';

import '../model/urine_model.dart';

class BluetoothStateProvider extends ChangeNotifier {

  bool _state = false;

  bool get state => _state;

  /// 시스템 블루투스 Off 상태
  setStateOff(){
    _state = false;
    mLog.i('[BluetoothStateProvider] state: 블루투스 OFF');
    notifyListeners();
  }

  /// 시스템 블루투스 ON 상태
  setStateOn(){
    _state = true;
    mLog.i('[BluetoothStateProvider] state: 블루투스 ON');
    notifyListeners();
  }

}