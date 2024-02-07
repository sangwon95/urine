
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:provider/provider.dart';
import 'package:urine/main.dart';
import 'package:urine/page/bluetooth/inspection_page.dart';
import 'package:urine/providers/count_provider.dart';
import '../../model/urine_model.dart';
import '../../utils/constants.dart';
import '../../utils/etc.dart';
import '../../utils/frame.dart';
import '../../widgets/progress_timeline.dart';
import 'connection_page.dart';
import 'preparation_page.dart';
import 'result_page.dart';

class BluetoothPage extends StatefulWidget {
  const BluetoothPage({Key? key, required this.countHomeIndex, this.writeCharacteristic, this.notificationCharacteristic}) : super(key: key);

  final int countHomeIndex;
  final BluetoothCharacteristic? writeCharacteristic;
  final BluetoothCharacteristic? notificationCharacteristic;

  @override
  State<BluetoothPage> createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {

  late int countIndex ;
  late BluetoothDevice? device;
  late BluetoothCharacteristic? writeCharacteristic;
  late BluetoothCharacteristic? notificationCharacteristic;
  late UrineModel? urineModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countIndex = widget.countHomeIndex;
    writeCharacteristic = widget.writeCharacteristic;
    notificationCharacteristic = widget.notificationCharacteristic;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mLog.i('bluetooth page build called');

    var mWidth = MediaQuery.of(context).size.width;
    var mHeight = MediaQuery.of(context).size.height;

    if(countIndex == -1){
      countIndex = 3;  
      Provider.of<CountProvider>(context).connected();
    }
    else if(countIndex == -2) {
      countIndex = 0;
      Provider.of<CountProvider>(context).clean();
    }
    else {
      countIndex = Provider.of<CountProvider>(context).count;
      notificationCharacteristic = Provider.of<CountProvider>(context).notificationCharacteristic;
      writeCharacteristic = Provider.of<CountProvider>(context).writeCharacteristic;
    }

    device = Provider.of<CountProvider>(context).device;
    urineModel = Provider.of<CountProvider>(context).urineModel;

    return Scaffold(
      appBar: Frame.myAppbar(
        '검사하기'
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          height: mHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 80,
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
      case 1: return PreparationPage(mWidth: mWidth);
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




