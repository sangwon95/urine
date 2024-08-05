

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:urine/common/common.dart';
import 'package:urine/layers/entity/urine_save_dto.dart';
import 'package:urine/layers/model/authorization.dart';

import '../../../../../../common/util/etc.dart';
import '../../../../../../main.dart';
import '../../../domain/usecase/urine/urine_save_usecase.dart';
import '../../../model/enum/bluetooth_status.dart';
import '../../../model/vo_urine.dart';
import '../../../model/vo_urine_row.dart';
import '../../widget/w_custom_dialog.dart';
import '../result/v_urine_result.dart';


class BluetoothConnectionViewModel extends ChangeNotifier{

  BuildContext context;
  BluetoothConnectionViewModel(this.context){
    initGattUuid();
    startScan();
  }

  ScanResult? scanResult;

  /// 검사기로부터 받은 데이터 버퍼
  StringBuffer sb = StringBuffer('');

  /// 화면에 보여줄 상태 텍스트
  String _stateText = '';

  /// 에러 발생시 보여줄 버튼이름
  String _buttonText = '';

  /// 에러 발생시 보여줄 위젯
  bool _isErrorWidget = false;

  /// progress bar image path
  String imagePath = '${Texts.imagePath}/urine/bluetooth/search.png';

  /// Notification Characteristic
  BluetoothCharacteristic? notificationChar;

  /// Write Characteristic
  BluetoothCharacteristic? writeChar;

  /// Bluetooth 연결 상태 Stream
  StreamSubscription? connectionSubscription;

  /// Bluetooth 응답 Stream
  StreamSubscription? receivedSubscription;

  /// scan timeout timer
  Timer? scanTimer;

  /// connect timeout timer
  Timer? connectTimer;

  /// write timeout timer
  Timer? writeTimer;

  /// 검사기와 연결 상태
  bool _isConnection = false;

  /// Gatt UUID
  late String _gattServiceUuid;
  late String _gattNotificationUuid;
  late String _gattWriteUuid;

  String get stateText => _stateText;
  String get buttonText => _buttonText;
  bool get isErrorWidget => _isErrorWidget;

  int get scanTimeCount => 10;   // 스캔 시간 10초
  int get connectTimeCount => 4; // 연결 시간 4초
  int get writeTimeCount => 9;   // write 응답받기까지 9초

  final inspectionItemTypeList = [
    'DT01',
    'DT02',
    'DT03',
    'DT04',
    'DT05',
    'DT06',
    'DT07',
    'DT08',
    'DT09',
    'DT10',
    'DT11',
  ];

  /// 결과데이터 Map 리스트
  List<Map<String, dynamic>> dataMap = <Map<String, dynamic>>[];


  /// 검사 결과 데이터 저장
  saveResultData(List<String> urineList) async {
    for(int i = 0 ; i < 11 ; i++){
      dataMap.add(
          UrineRow(
              Authorization().userID,
              DateFormat('yyyyMMddHHmmss').format(DateTime.now()).toString(),
              inspectionItemTypeList[i],
              urineList[i] != '0' ? '양성' : '음성',
              urineList[i]
          ).toMap()
      );
    }

    UrineSaveDTO? response = await UrineSavaUesCase().execute(dataMap);
    if(response?.status.code == '200'){
      logger.i('유린기 검사 데이터 저장 완료!');
    } else {
      logger.i('유린기 검사 데이터 저장 실패:${response?.status.code}');
    }
  }


  /// 블루투스 스캔 시작
  startScan() async {
    configureView(BluetoothStatus.scan);

    var subscription = FlutterBluePlus.onScanResults.listen((results) {
      if (results.isNotEmpty) {
        scanResult = results.last; // the most recently found device
        logger.i('${scanResult!.device.remoteId}: "${scanResult!.advertisementData.advName}" found!');
        connectionDevice(scanResult!);
      }
    },
    );
    await FlutterBluePlus.startScan(
      withKeywords: BLECommunicationManager.withKeywords,
    );
    startScanTimer();

    FlutterBluePlus.cancelWhenScanComplete(subscription);
  }


  /// 블루투스 연결
  connectionDevice(ScanResult scanResult){
    scanTimer?.cancel();
    configureView(BluetoothStatus.connect);
    FlutterBluePlus.stopScan();

    startConnectTimer();
    scanResult.device.connect(autoConnect: false);
    connectionListener(scanResult);
  }


  /// 블루투스 연결 상태(Connected, Disconnected) 리스너
  connectionListener(ScanResult scanResult) {
    connectionSubscription = scanResult.device.connectionState.listen((value){
      switch (value) {
        case BluetoothConnectionState.connected: {
          logger.i('블루투스 연결됨!');
          _isConnection = true;
          discoverServices(scanResult);
          break;
        }
        case BluetoothConnectionState.disconnected:{
          logger.i('블루투스 연결끊어짐!');
          _isConnection = false;
          checkConnectionHistory();
          break;
        }
        default:
          logger.i('블루투스 연결 미상');
          break;
      }
    });
  }


  /// 블루트스 Gatt service 찾는다.
  discoverServices(ScanResult scanResult) async {
    List<BluetoothService> services = await scanResult.device.discoverServices();
    for (var service in services) {
      if(service.uuid.toString() == _gattServiceUuid){
        for(BluetoothCharacteristic char in service.characteristics) {

          ///NOTIFICATION UUID
          if(char.characteristicUuid.toString() == _gattNotificationUuid){
            notificationChar = char;
            writeResponseListener();
          }
          ///WRITE UUID
          if(char.characteristicUuid.toString() == _gattWriteUuid){
            writeChar = char;
          }
        }
      }
    }
    writeToBLEDevice();
  }


  /// BLE 연결 후 write
  writeToBLEDevice() async {
    if(notificationChar != null && writeChar != null) {
      notificationChar!.setNotifyValue(true).then((isNotify) => {
        configureView(BluetoothStatus.inspection),
        logger.i('isNotify: $isNotify'),

        writeChar!.write(
          Etc.hexStringToByteArray(BLECommunicationManager.commandTs),
          withoutResponse: BLECommunicationManager.withoutResponse,
        ),

        startWriteTimer(), // 검사 Time out 시작
      });
    } else {
      // 검사할 수 있는 gatt service가 없습니다.
      configureView(BluetoothStatus.unableError);
    }
  }


  /// 검사기으로부터 받는 데이터 리스너
  writeResponseListener() {
    receivedSubscription = notificationChar!.onValueReceived.listen((value) {
      // 버퍼에 수신된 데이터를 쌓는다.
      sb.write((String.fromCharCodes(value)).replaceAll('\n', ''));
      logger.i(sb);

      if(sb.toString().contains('ERR')) {
        configureView(BluetoothStatus.stripError);
      }

      if(sb.toString().contains('#A11')){
        logger.i('검사기로부터 수신된 데이터: ${sb.toString().replaceAll('\n', '')}');
        List<String> urineList = Etc.createUrineValuesList(Urine.fromValue(sb.toString()));

        if(urineList.isNotEmpty && urineList.length == 11){
          // 결과 데이터 서버에 저장
          saveResultData(urineList);

          allClean();
          Nav.doPop(context); // 현재 검사 진행 화면 pop
          Nav.doPush(context, UrineResultView(urineList: urineList, testDate: DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now()).toString()));
        } else {
          Nav.doPop(context); // 현재 검사 진행 화면 pop
          CustomDialog.showMyDialog(
            title: '검사 오류',
            content: '정상적으로 검사가 완료되지 않았습니다.\n다시 시도해 주세요.',
            mainContext: context,
          );
        }
      }
    });
  }


  /// 검사기를 찾지 못했을 경우 타임아웃
  startScanTimer() async {
    scanTimer = Timer(scanTimeCount.seconds, () {
      if (scanResult == null) {
        logger.i('scanTimeOut: 검사기를 찾지 못했습니다. 스캔 중지');
        FlutterBluePlus.stopScan();
        configureView(BluetoothStatus.scanError);
      }
    });
  }



  /// 검사기외 연결하지 못했을 경우 타임아웃
  startConnectTimer() async {
    connectTimer = Timer(connectTimeCount.seconds, () {
      if (!_isConnection) {
        logger.i('connectTimeOut: 검사기와 연결하지 못함!');
        configureView(BluetoothStatus.connectError);
      }
    });
  }


  /// 검사기로 write를 했을때 [onValueReceived].[listen]를 통해서
  /// 응답을 받았는지 확인 한다.
  startWriteTimer() {
    writeTimer = Timer(writeTimeCount.seconds, () {
      if (sb.isEmpty) {
        configureView(BluetoothStatus.inspectionError);
      }
    });
  }


  /// 찾은 검사기와 재연결 시도
  retryConnection() {
    configureView(BluetoothStatus.connect);
    scanResult!.device.connect(autoConnect: false);
  }


  /// 재 검사
  /// [writeTimeOut]를 통해 8초동안 응답을 받지 못했을 경우
  /// [retryWrite]를 호출하여 다시 재전송 할 수 있다.
  retryWrite() => writeToBLEDevice();



  /// Bluetooth 상태에 따라 화면을 구성한다.
  configureView(BluetoothStatus status){
    switch(status){
      case BluetoothStatus.scan: {
        imagePath = '${Texts.imagePath}/urine/bluetooth/search.png';
        _stateText = status.message;
        _buttonText = '';
        _isErrorWidget = false;
      }
      case BluetoothStatus.connect: {
        imagePath = '${Texts.imagePath}/urine/bluetooth/connection.png';
        _stateText = status.message;
      }
      case BluetoothStatus.inspection: {
        imagePath = '${Texts.imagePath}/urine/bluetooth/inspection.png';
        _stateText = status.message;
        _buttonText = '';
        _isErrorWidget = false;
      }
      case BluetoothStatus.scanError: {
        imagePath = '${Texts.imagePath}/urine/bluetooth/search_failure.png';
        _stateText = status.message;
        _buttonText = '재 검색';
        _isErrorWidget = true;
      }
      case BluetoothStatus.connectError: {
        imagePath = '${Texts.imagePath}/urine/bluetooth/connection_failure.png';
        _stateText = status.message;
        _buttonText = '재 연결';
        _isErrorWidget = true;
      }
      case BluetoothStatus.inspectionError: {
        imagePath = '${Texts.imagePath}/urine/bluetooth/inspection_failure.png';
        _stateText = status.message;
        _buttonText = '재 검사';
        _isErrorWidget = true;
      }
      case BluetoothStatus.stripError: {
        imagePath = '${Texts.imagePath}/urine/bluetooth/inspection_failure.png';
        _stateText = status.message;
        _buttonText = '재 검사';
        _isErrorWidget = true;
      }
      case BluetoothStatus.cutoff: {
        imagePath = '${Texts.imagePath}/urine/bluetooth/connection_failure.png';
        _stateText = status.message;
        _buttonText = '재 검색';
        _isErrorWidget = true;
      }
      case BluetoothStatus.unableError:{
        imagePath = '${Texts.imagePath}/urine/bluetooth/connection.png';
        _stateText = status.message;
        _buttonText = '재 검색';
        _isErrorWidget = true;
      }
    }
    notifyListeners();
  }


  /// 에러 발생시 재 검색, 재 연결, 재 검사를 할 수 있다.
  onPressedError(){
    switch(_buttonText){
      case '재 검색': {
        allClean();
        startScan();
        break;
      }
      case '재 연결': {
        retryConnection();
        break;
      }
      case '재 검사': {
        retryWrite();
        break;
      }
    }
  }


  /// 검사기와 연결 이력이 있는지 확인한다.
  /// 연결 -> 미연결 상태 변화를 확인 할 수있다.
  void checkConnectionHistory() {
    // 연결은 끊어졌고 연결시 notificationChar 값이 남아 있을 경우
    if(!_isConnection && notificationChar != null){
      logger.i('검사기로부터 연결이 끊어졌습니다.');

      configureView(BluetoothStatus.cutoff);
      allClean();
    }
  }

  /// 모두 초기화
  allClean(){
    scanResult?.device.disconnect();
    scanResult = null;
    sb.clear();

    scanTimer?.cancel();
    connectTimer?.cancel();
    writeTimer?.cancel();

    scanTimer = null;
    connectTimer = null;
    writeTimer = null;

    notificationChar = null;
    writeChar = null;

    connectionSubscription?.cancel();
    receivedSubscription?.cancel();
  }


  /// Gatt UUID 초기화
  initGattUuid(){
    logger.d('toggleGatt: ${Authorization().toggleGatt}');
   if(Authorization().toggleGatt){
     _gattServiceUuid = BLECommunicationManager.oldGattServiceUuid;
     _gattNotificationUuid = BLECommunicationManager.oldGattNotificationUuid;
     _gattWriteUuid = BLECommunicationManager.oldGattWriteUuid;
   } else {
     _gattServiceUuid = BLECommunicationManager.gattServiceUuid;
     _gattNotificationUuid = BLECommunicationManager.gattNotificationUuid;
     _gattWriteUuid = BLECommunicationManager.gattWriteUuid;
   }
  }

}




