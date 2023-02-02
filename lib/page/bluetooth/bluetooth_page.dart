
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:provider/provider.dart';
import 'package:urine/main.dart';
import 'package:urine/model/bluetooth_ble.dart';
import 'package:urine/page/bluetooth/inspection_page.dart';
import 'package:urine/page/bluetooth/search_device_page.dart';
import 'package:urine/utils/count_provider.dart';
import '../../model/urine_model.dart';
import '../../utils/constants.dart';
import '../../utils/etc.dart';
import '../../widgets/progress_timeline.dart';
import 'connection_page.dart';
import 'preparation_page.dart';
import 'result_page.dart';

class BluetoothPage extends StatefulWidget {
  const BluetoothPage({Key? key}) : super(key: key);

  @override
  State<BluetoothPage> createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {

  int countIndex = 0;
  late BluetoothDevice? device;
  late BluetoothCharacteristic? writeCharacteristic;
  late BluetoothCharacteristic? notificationCharacteristic;
  late UrineModel? urineModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// 연결 되어 있는지
    /// 준비 및 연결 과정이 필요한지 체크 해야된다.


    FlutterBluePlus.instance.connectedDevices.then((value){
      mLog.i('connectedDevices : $value');
      if(value.length>0){
        countIndex = -1;
        _bluetoothGattServiceLister(value[0]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var mWidth = MediaQuery.of(context).size.width;
    var mHeight = MediaQuery.of(context).size.height;

    if(countIndex == -1){
      countIndex = 3;
      Provider.of<CountProvider>(context).connected();
    } else {
      countIndex = Provider.of<CountProvider>(context).count;
      notificationCharacteristic = Provider.of<CountProvider>(context).notificationCharacteristic;
      writeCharacteristic = Provider.of<CountProvider>(context).writeCharacteristic;
    }

    device = Provider.of<CountProvider>(context).device;
    urineModel = Provider.of<CountProvider>(context).urineModel;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          height: mHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                child: ProcessTimelinePage(processIndex: countIndex)
              ),

              _stepView(mWidth, mHeight),
            ],
          ),
        ),
      ),
    );
  }

  _stepView(double mWidth, double mHeight) {
    switch(countIndex){
      case 0: return PreparationPage(mWidth: mWidth);
      case 1: return SearchDevicePage();
      case 2: return ConnectionPage(device: device);
      case 3: return InspectionPage(
        writeCharacteristic: writeCharacteristic,
        notificationCharacteristic: notificationCharacteristic,);
      case 4: return ResultPage(urineModel: urineModel);
      default: return PreparationPage(mWidth: mWidth);
    }
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
         notificationCharacteristic =
          Etc.findBluetoothCharacteristic(bluetoothService, BLE_GATT_UUID_NOTIFICATION)!;

          /// writeCharacteristic 찾기
         writeCharacteristic =
          Etc.findBluetoothCharacteristic(bluetoothService, BLE_GATT_UUID_WRITE)!;

          // isWrite = true;
          // isNotification = true;
          // isLoading = false;
          // mLog.i('isRunOnce 실행');
          // _setNotification(notificationCharacteristic, writeCharacteristic);
        }
      }
    });
  }







}




