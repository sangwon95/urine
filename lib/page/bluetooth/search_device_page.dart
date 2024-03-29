
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../main.dart';
import '../../model/authorization.dart';
import '../../model/raw_insert_data.dart';
import '../../model/urine_model.dart';
import '../../utils/color.dart';
import '../../utils/constants.dart';
import '../../utils/dio_client.dart';
import '../../utils/etc.dart';
import '../../utils/frame.dart';


enum BluetoothStatusType { search, connection, inspection }


/// 기기 찾기
class SearchDevicePage extends StatefulWidget {
  const SearchDevicePage({Key? key, required this.onBackCallbackResult}) : super(key: key);

  final Function(UrineModel) onBackCallbackResult;

  @override
  State<SearchDevicePage> createState() => _SearchDevicePageState();
}

class _SearchDevicePageState extends State<SearchDevicePage> {

  /// step 1: 기기 찾기
  late bool isDeviceFound;

  late BluetoothDevice device;
  late String stateText;

  bool isShowButton = false;
  String btnText = '';
  late Widget stateWidget;

  BluetoothCharacteristic? notificationCharacteristic = null;
  BluetoothCharacteristic? writeCharacteristic = null;
  StreamSubscription<BluetoothConnectionState>? connectionLister = null;
  StreamSubscription<List<BluetoothService>>? serviceLister = null;
  StreamSubscription<List<int>>? onValueChangedStream = null;

  StringBuffer sb = StringBuffer('');
  late bool isNotifyValue;
  late Size size;
  bool isNoResponse = true;

  /// Bluetooth 연결 상태
  bool connectState = false;
  bool isOnceRun = true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _configureInitSearch(); // 초기 검색화면 구성
    _bluetoothScanResultsLister(); // 블루투스 스캔 리스너 등록
    _bluetoothScanStart();

    stateWidget = _buildProgressView(BluetoothStatusType.search);
  }
  @override
  void dispose() {


    super.dispose();
  }


  /// 검색 View
  _configureInitSearch() {
    isDeviceFound = false;
    stateText = '검사기를 찾고있습니다.\n잠시만 기다려 주세요.';
    stateWidget = _buildProgressView(BluetoothStatusType.search);
  }

  _configureInitConnection() {
    isDeviceFound = true;
    stateText = '연결 중입니다.\n 잠시만 기다려 주세요.';
    stateWidget = _buildProgressView(BluetoothStatusType.connection);
  }

  _configureInitCompleted() {
    isDeviceFound = true;
    stateText = '검사 진행 중입니다. \n 잠시만 기다려 주세요.';
    stateWidget = _buildProgressView(BluetoothStatusType.inspection);
    isShowButton = false;
  }


  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Frame.myAppbar(
        '검사 진행'
      ),
      body: Container(
        decoration:  BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight,
              colors: [
                Color(0xff5d9bef),
                Color(0xff7cbdd0),
              ],
              stops: [
                0.1, 1.0
              ],
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:
          [
            /// 상태 이미지
            stateWidget,

            /// 상태 텍스트
            SizedBox(
              width: double.infinity,
              child: Frame.myText(
                  text: stateText,
                  maxLinesCount: 3,
                  fontSize: 1.2,
                  fontWeight: FontWeight.w600,
                  align: TextAlign.center
              ),
            ),

            SizedBox(height: 50),

            /// 버튼
            Visibility(
                visible: isShowButton, // 파동을 없애는 동시에 버튼 생성
                child: _buildNextButton(btnText)
            )
          ],
        ),
      ),
    );
  }


  _buildProgressView(BluetoothStatusType type) {
    return Container(
      padding: const EdgeInsets.only(top: 170, bottom: 30),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Image.asset(
              type == BluetoothStatusType.search ? 'images/search.png':
              type == BluetoothStatusType.connection ? 'images/connection.png':
              'images/inspection.png', width: 100, height: 100),
        ),
      )
    );
  }


  _buildErrorView(BluetoothStatusType type) {
    return Container(
      padding: const EdgeInsets.only(top: 170, bottom: 30),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Image.asset(
              type == BluetoothStatusType.search ? 'images/search_failure.png':
              type == BluetoothStatusType.connection ? 'images/connection_failure.png':
              'images/inspection_failure.png', width: 100, height: 100),
        ),
      )
    );
  }


  /// 버튼
  _buildNextButton(String btnText){
    return Container(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        width: double.infinity,
        child: TextButton(
            style: TextButton.styleFrom(
                elevation: 5.0,
                backgroundColor: mainColor,
                padding: EdgeInsets.all(17.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
            onPressed: () {
              switch(btnText){
                case '재 시도': _againSearch(); break;
                case '재 연결': _againConnection(); break;
                case '재 검사': {
                  setState(() {
                    isNoResponse = true;
                    _configureInitCompleted();
                    _startInspection();
                  });
                  break;
                }
              }
            },
            child: Text(btnText, textScaleFactor: 1.1, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))
        )
    );
  }


  /// 디바이스 찾기 결과 리스너
  _bluetoothScanResultsLister() {
    _connectionTimeOut();

    FlutterBluePlus.scanResults.listen((results) {
      for (ScanResult r in results) {
        mLog.i('remoteId: ${r.device.remoteId}');
        mLog.i('remoteId.str: ${r.device.remoteId.str}');

        if(r.device.platformName.contains('PhotoMT')|| r.device.platformName.contains('YOCHECK') || r.device.platformName.contains('OptoSta')){
          print('>>>>>>>r.device: ${r.device} isOnceRun: ${isOnceRun}');
          FlutterBluePlus.stopScan();
            if(isOnceRun){
              mLog.i('안쪽 실행');
              isOnceRun = false;
              if(mounted){
                setState(() {
                  device = r.device;
                  addBluetoothDeviceConnectionLister(device); // 디바이스 연결 상태 리스너 등록
                  device.connect(autoConnect: false);
                  _configureInitConnection();
                });
              }
            }
          return;
        }
      }
    });
  }

  /// 연결이 잘되었는지 4초 뒤에 획인한다.
  void _connectionTimeOut() {
    Future.delayed(Duration(seconds: 5),(){
      if(!connectState && mounted){
          setState(() {
            isShowButton = true;
            stateText = '유린검사기와 정상적으로 연결되지 않았습니다.';
            btnText = '재 시도';
            stateWidget = _buildErrorView(BluetoothStatusType.connection);
          });
      }
    });
  }


  /// 선택된 디바이스 연결 상태 리스너
  addBluetoothDeviceConnectionLister(BluetoothDevice device){
    connectionLister = device.connectionState.listen((value){
      switch (value) {
        case BluetoothConnectionState.connected: {
          connectState = true;
          mLog.i('[BluetoothDeviceState]: Connected!');
          if(serviceLister == null){ // 등록된 GattServiceLister 가 없으면 실행된다.
            device.discoverServices().then((service){
              for (var value in service) {
                mLog.i('gattService: ${value.uuid}');
                for (var characteristics in value.characteristics) {
                  mLog.i('characteristics: ${characteristics.uuid}');
                }
              }

              if (service.length > 0) {
                if (notificationCharacteristic == null && writeCharacteristic == null) {
                  /// Gatt Service 찾기
                  BluetoothService? bluetoothService = Etc.findBluetoothService(service);

                  if (bluetoothService == null) {
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
                  _setNotification();
                }
              } else {
                mLog.i('[gattService.length]:${service.length}');
              }


            });
            //addBluetoothGattServiceLister();
          } else {
            mLog.i('[BluetoothController] serviceLister: 리스너가 등록 되어 있다.');
          }
          break;
        }
        case BluetoothConnectionState.disconnected:
          connectState = false;
          mLog.i('[BluetoothController]: Disconnected!');
          break;
        default:
          mLog.d('BluetoothDeviceState.connected : ${value.toString().substring(21).toUpperCase()}');
          break;
      }
    });
  }

  /// GattServiceLister 등록
  /// notification,write Characteristic 찾는다.
  addBluetoothGattServiceLister() {
    mLog.i("[BluetoothController/addBluetoothGattServiceLister] device.id: ${device.id} 실행");


    serviceLister = device.services.listen((List<BluetoothService> gattService) {
      for (var value in gattService) {
        mLog.i('gattService: ${value.uuid}');
        for (var characteristics in value.characteristics) {
          mLog.i('characteristics: ${characteristics.uuid}');
        }
      }

      if (gattService.length > 0) {
        if (notificationCharacteristic == null && writeCharacteristic == null) {
          /// Gatt Service 찾기
          BluetoothService? bluetoothService = Etc.findBluetoothService(gattService);

          if (bluetoothService == null) {
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
          _setNotification();
        }
      } else {
        mLog.i('[gattService.length]:${gattService.length}');
      }
    });


  }


  /// 지정된 특성 값에 대한 알림 또는 표시를 설정합니다.
  _setNotification() async {
    if(notificationCharacteristic != null){
      try {
        await notificationCharacteristic!.setNotifyValue(true);
        addValueChangedStreamListener();

        Future.delayed(Duration(seconds: 1),(){
          if (mounted) {
            setState(() {
              _configureInitCompleted();
              _startInspection();
            });
          } else {
            mLog.i('isNotifyValue: false');
          }
        });
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
      mLog.i('addValueChangedStreamListener 등록 실행');
      onValueChangedStream = notificationCharacteristic!.onValueChangedStream.listen((value)
      {
        sb.write((String.fromCharCodes(value)).replaceAll('\n', '')); // 버퍼에 수신된 데이터를 쌓는다.

        if (sb.toString().contains('#A11')) {
          mLog.d('replaceAll: ${sb.toString().replaceAll('\n', '')}');
          //isWriting = true; // 검사 종료

          UrineModel urineModel = UrineModel();
          urineModel.initialization(sb.toString());
          mLog.i(urineModel.toString());

          /// 서버에 수집된 데이터 저장
          _saveResultData(urineModel);
          _dispose();

          Navigator.pop(context);

          /// callback 함수로 홈 화면에서 결과데이터를 보여준다.
          widget.onBackCallbackResult(urineModel);
        }

        /// 스트립 미삽입
        else if(sb.toString().contains('ERR')) {
          emptyStrip();
          isNoResponse = false;
        }
      });
    } else {
      mLog.d('NOT BLE_GATT_UUID_NOTIFICATION');
    }
  }


  /// 검사 시작
  Future<void> _startInspection() async {
    if(writeCharacteristic != null){
      await writeCharacteristic!.write(Etc.hexStringToByteArray('2554530a'), withoutResponse: true);

      /// 소변 분석 Timeout
      /// write 후 9초동안 응답이 오지 않을 경우 Progress 화면을 종료 한다.
      Future.delayed(Duration(seconds: 9),(){
        mLog.i('startInspection() / popProgress() : ${sb.length}');
        if(isNoResponse && mounted){
          setState((){
            stateWidget = _buildErrorView(BluetoothStatusType.inspection);
            stateText = '검사기로부터 데이터를 받지 못했습니다.\n다시 시도바랍니다.';
            isShowButton = true;
            btnText = '재 검사';
          });
          isNoResponse = true;
        }
      });

    } else {
      mLog.i('[writeCharacteristic null] 검사를 시작 하지 못했습니다.');
    }
  }


  /// 스트립이 비어 있을 경우
  emptyStrip(){
    setState((){
      stateWidget = _buildErrorView(BluetoothStatusType.inspection);
      stateText = '스트립이 비어 있습니다.\n 삽입 후 재검사 버튼을 눌러주세요.';
      isShowButton = true;
      btnText = '재 검사';
    });
  }


  /// 스켄 시작
  _bluetoothScanStart(){
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 4));
    Future.delayed(Duration(seconds: 5), (){
      // 검사기를 찾지 못했을 경우 재시도 버튼 생성
      if(!isDeviceFound){
        setState(() {
          isShowButton = true;
          stateText = '유린검사기를 찾지 못했습니다.\n검사기가 켜져있는지 확인해보세요.';
          btnText = '재 시도';
          isOnceRun = true;
          stateWidget = _buildErrorView(BluetoothStatusType.search);
          FlutterBluePlus.stopScan();
        });
      }
    });
  }


  /// 디바이스 재 검색
  _againSearch(){
    if(mounted){
      setState(() {
        isShowButton = false;
        _configureInitSearch(); // view 초기화
        _bluetoothScanStart(); // 블루투스 검색 재시작
      });
    }
  }

  /// 디바이스 재 연결
  _againConnection(){
    if(mounted){
      setState(() {
        isShowButton = false;
        _configureInitConnection(); // view 초기화
        _bluetoothScanStart(); // 블루투스 검색 재시작
      });
    }
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

  _dispose(){
    device.clearGattCache();
    device.disconnect();

    serviceLister?.cancel();
    connectionLister?.cancel();
    onValueChangedStream?.cancel();

    sb.clear();
    isOnceRun = true;
    isNoResponse = true;
    notificationCharacteristic = null;
    writeCharacteristic = null;

    isNotifyValue = false;
    serviceLister = null;
    connectionLister = null;
  }
}

// _buildSearchView() {
//   return Container(
//         width: double.infinity,
//           padding: const EdgeInsets.fromLTRB(15, 30, 15, 10),
//           child: AvatarGlow(
//             glowColor: mainColor,
//             endRadius: 130.0,
//             duration: Duration(milliseconds: 2000),
//             repeat: isShowGlows,
//             showTwoGlows: isShowGlows,
//             animate: isShowGlows,
//             repeatPauseDuration: Duration(milliseconds: 200),
//             child: Material(     // Replace this child with your own
//               elevation: 4.0,
//               shape: CircleBorder(),
//               child: CircleAvatar(
//                 backgroundColor: Colors.grey[100],
//                 child: Icon(Icons.bluetooth, color: Colors.blue, size: 50),
//                 radius: 45.0,
//               ),
//             ),
//           ),
//       );
// }