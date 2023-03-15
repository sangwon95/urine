import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:urine/main.dart';
import '../model/authorization.dart';
import '../utils/my_shared_preferences.dart';
import '../widgets.dart';

/// 블루투스 디바이스 기기 찾기 화면
class FindDevicesPage extends StatefulWidget {
  final Function(BluetoothDevice) onBackCallbackConnect;

  FindDevicesPage({required this.onBackCallbackConnect});

  @override
  State<FindDevicesPage> createState() => _FindDevicesPageState();
}

class _FindDevicesPageState extends State<FindDevicesPage> {


  @override
  initState(){
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Devices'),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.blueAccent,
              onPrimary: Colors.white,
            ),
            onPressed: Platform.isAndroid
                ? () => FlutterBluePlus.instance.turnOff()
                : null,
            child: const Text('TURN OFF'),
          ),
        ],
      ),

      body: RefreshIndicator(
        onRefresh: () => FlutterBluePlus.instance.startScan(timeout: const Duration(seconds: 4)),
        child: SingleChildScrollView(
          child: Column(
            children:
            [
              /// 디바이스와 연결이 되어 있는 상태
              // StreamBuilder<List<BluetoothDevice>>(
              //   stream: Stream.periodic(const Duration(seconds: 2)).asyncMap((_) => FlutterBluePlus.instance.connectedDevices),
              //   initialData: const [],
              //   builder: (c, snapshot) =>
              //       Column(
              //         children: snapshot.data!.map((device) =>
              //             ListTile(
              //               title: Text(device.name),
              //               subtitle: Text(device.id.toString()),
              //               trailing: StreamBuilder<BluetoothDeviceState>(
              //                 stream: device.state,
              //                 initialData: BluetoothDeviceState.disconnected,
              //                 builder: (c, snapshot)
              //                 {
              //                   mLog.d('BluetoothDeviceState: ${snapshot.data}');
              //                   if (snapshot.data == BluetoothDeviceState.connected) {
              //                     return ElevatedButton(
              //                       child: const Text('OPEN'),
              //                       onPressed: () =>
              //                           Navigator.of(context).push(MaterialPageRoute(builder: (context) => DeviceScreen(device: device))),
              //                     );
              //                   }
              //                   return Text(snapshot.data.toString());
              //                 },
              //               ),
              //             ))
              //             .toList(),
              //       ),
              // ),

              StreamBuilder<List<ScanResult>>(
                stream: FlutterBluePlus.instance.scanResults,
                initialData: const [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data!.map((r) => ScanResultTile(
                      result: r,
                      onTap: () =>{
                        Navigator.pop(context),
                        widget.onBackCallbackConnect(r.device),
                        _saveAddress(r.device.id.id),
                        mLog.d('연결디바이스 address : ${r.device.id.id}')
                        /// 이때 디바이스 데이터 저장
                      }
                      )
                  ).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: StreamBuilder<bool>(
        stream: FlutterBluePlus.instance.isScanning,
        initialData: false,
        builder: (c, snapshot)
        {
          if (snapshot.data!) {
            return FloatingActionButton(
              child: const Icon(Icons.stop),
              onPressed: () => FlutterBluePlus.instance.stopScan(),
              backgroundColor: Colors.red,
            );
          }
          else {
            return FloatingActionButton(
                child: const Icon(Icons.search),
                onPressed: () => FlutterBluePlus.instance.startScan(timeout: const Duration(seconds: 4)));
          }
        },
      ),
    );
  }

  _saveAddress(String address) async{
    MySharedPreferences _saveData = MySharedPreferences();
    _saveData.setStringData('address', Authorization().userID);
  }
}