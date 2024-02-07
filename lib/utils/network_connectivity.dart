import 'package:flutter/cupertino.dart';
import 'package:flutter_network_connectivity/flutter_network_connectivity.dart';

import '../widgets/dialog.dart';


/// 네트워크 상태 확인
class NetWorkConnectivity{

  static final NetWorkConnectivity netWorkConnectivity = NetWorkConnectivity.internal();

  static BuildContext? mContext;

  final FlutterNetworkConnectivity _flutterNetworkConnectivity =
  FlutterNetworkConnectivity(
    isContinousLookUp: true,
    // optional, false if you cont want continous lookup
    lookUpDuration: const Duration(seconds: 3),
    // optional, to override default lookup duration
    lookUpUrl: 'wonpl.co.kr', // optional, to override default lookup url
  );


  factory NetWorkConnectivity({required BuildContext context}){
    mContext = context;
    return netWorkConnectivity;
  }

  NetWorkConnectivity.internal() {

    /// if status is false can't call anymore
    bool status = true;

    _flutterNetworkConnectivity.getInternetAvailabilityStream().listen((event)
    {
      if(!event) {
        if(status) {
          status = false;
          CustomDialog.showNetworkDialog('네트워크 연결!', '네트워크 연결을 확인해주세요.', mContext!, (){
            /// 네트워크 다이얼로그 중첩을 방지하기위해
            status = true;
            Navigator.pop(mContext!);
          });
        }
      }
    });

    //init();
  }

  void init() async {
    await _flutterNetworkConnectivity.registerAvailabilityListener();
  }


}