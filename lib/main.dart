
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:async';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urine/page/home_page.dart';
import 'package:urine/page/login_page.dart';
import 'package:urine/providers/bluetooth_state_provider.dart';
import 'package:urine/utils/color.dart';
import 'package:urine/providers/count_provider.dart';
import 'package:urine/utils/dio_client.dart';
import 'package:urine/utils/logging.dart';

import 'model/authorization.dart';

/// Custom Log
final mLog = logger;

Future<void> main() async{

  /// 플랫폼 채널의 위젯 바인딩을 보장해야한다.
  WidgetsFlutterBinding.ensureInitialized();
  await _initAuthorization();



  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => CountProvider()),
          ChangeNotifierProvider(create: (context) => BluetoothStateProvider()),
        ],
        child: FlutterBlueApp(),
      )
  );
}

/// Authorization 초기화
_initAuthorization() async {

  var pref = await SharedPreferences.getInstance();
  String? password = pref.getString('password');
  String? userID = pref.getString('userID');

  if(userID != null && password != null) {
    Authorization().userID = userID;
    Authorization().password = password;

    final login = await client.dioLogin(Authorization().toMap());
    Authorization().token = login.token;
  }
}

class FlutterBlueApp extends StatelessWidget {
  final themeData = ThemeData(pageTransitionsTheme: PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ));

  @override
  Widget build(BuildContext context) {

    /// 앱 화면 세로 위쪽 방향으로 고정
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      title: 'HealthCare',
      color: Colors.lightBlue,
      debugShowCheckedModeBanner: false,
      theme:Theme.of(context).copyWith(
          colorScheme: themeData.colorScheme.copyWith(primary: mainColor),
          //primaryTextTheme: themeData.textTheme.apply(fontFamily: 'nanum_square')
      ),
      localizationsDelegates:
      const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      supportedLocales:
      [
        Locale('ko', ''),
        Locale('en', ''),
      ],

      initialRoute:// 'login_page',
      Authorization().userID == ''? 'login_page' : 'home_page',
      routes:
      {
        'login_page': (context) => LoginPage(),
        'home_page': (context) => HomePage(),
        //'test_view': (context) => SearchDevicePage2(onBackCallbackConnect: (BluetoothDevice ) {  },),
        //'connection_page': (context) => BluetoothPage(),

      },

      // [StreamBuilder]: 데이터가 변하는 걸 보고 있다가 그에
      // 맞춰 적절한 처리 및 필터링 수정 버퍼링 같은 일을 한다.
      // home: StreamBuilder<BluetoothState>(
      //     stream: FlutterBluePlus.instance.state,
      //     initialData: BluetoothState.unknown,
      //     builder: (c, snapshot)
      //     {
      //       final state = snapshot.data;
      //
      //       if (state == BluetoothState.on) {
      //         return const FindDevicesScreen();
      //       }
      //
      //       return BluetoothOffScreen(state: state);
      //     }
      //  ),
    );
  }
}


/// 블루투스가 켜져있지 않는 경우
// class BluetoothOffScreen extends StatelessWidget {
//   const BluetoothOffScreen({Key? key, this.state}) : super(key: key);
//
//   final BluetoothState? state;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.lightBlue,
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             const Icon(
//               Icons.bluetooth_disabled,
//               size: 200.0,
//               color: Colors.white54,
//             ),
//             Text(
//               'Bluetooth Adapter is ${state != null ? state.toString().substring(15) : 'not available'}.',
//               style: Theme.of(context)
//                   .primaryTextTheme
//                   .subtitle2
//                   ?.copyWith(color: Colors.white),
//             ),
//             ElevatedButton(
//               onPressed: Platform.isAndroid
//                   ? () => FlutterBluePlus.turnOn()
//                   : null,
//               child: const Text('TURN ON'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


/// 블루투스 디바이스 기기 찾기 화면
// class FindDevicesScreen extends StatelessWidget {
//   const FindDevicesScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Find Devices'),
//         actions: [
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               primary: Colors.blueAccent,
//               onPrimary: Colors.white,
//             ),
//             onPressed: Platform.isAndroid
//                 ? () => FlutterBluePlus.turnOn()
//                 : null,
//             child: const Text('TURN OFF'),
//           ),
//         ],
//       ),
//       body: RefreshIndicator(
//         onRefresh: () => FlutterBluePlus.startScan(timeout: const Duration(seconds: 4)),
//         child: SingleChildScrollView(
//           child: Column(
//             children:
//             [
//               /// 디바이스와 연결이 되어 있는 상태
//               StreamBuilder<List<BluetoothDevice>>(
//                 stream: Stream.periodic(const Duration(seconds: 2)).asyncMap((_) => FlutterBluePlus.connectedDevices),
//                 initialData: const [],
//                 builder: (c, snapshot) =>
//                     Column(
//                       children: snapshot.data!.map((device) =>
//                           ListTile(
//                             title: Text(device.name),
//                             subtitle: Text(device.id.toString()),
//                             trailing: StreamBuilder<BluetoothDeviceState>(
//                               stream: device.state,
//                               initialData: BluetoothDeviceState.disconnected,
//                               builder: (c, snapshot)
//                               {
//                                 mLog.d('BluetoothDeviceState: ${snapshot.data}');
//                                 if (snapshot.data == BluetoothDeviceState.connected) {
//                                   return ElevatedButton(
//                                     child: const Text('OPEN'),
//                                     onPressed: () =>
//                                         Navigator.of(context).push(MaterialPageRoute(builder: (context) => DeviceScreen(device: device))),
//                                   );
//                                 }
//                                 return Text(snapshot.data.toString());
//                               },
//                             ),
//                           ))
//                       .toList(),
//                 ),
//               ),
//               StreamBuilder<List<ScanResult>>(
//                 stream: FlutterBluePlus.instance.scanResults,
//                 initialData: const [],
//                 builder: (c, snapshot) => Column(
//                   children: snapshot.data!.map((r) => ScanResultTile(
//                           result: r,
//                           onTap: () =>
//                               Navigator.of(context).push(MaterialPageRoute(builder: (context) {
//                                 return DeviceScreen(device: r.device);
//                           })),
//                         ),
//                       )
//                       .toList(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: StreamBuilder<bool>(
//         stream: FlutterBluePlus.instance.isScanning,
//         initialData: false,
//         builder: (c, snapshot)
//         {
//           if (snapshot.data!) {
//             return FloatingActionButton(
//               child: const Icon(Icons.stop),
//               onPressed: () => FlutterBluePlus.instance.stopScan(),
//               backgroundColor: Colors.red,
//             );
//           }
//           else {
//             return FloatingActionButton(
//                 child: const Icon(Icons.search),
//                 onPressed: () => FlutterBluePlus.instance
//                     .startScan(timeout: const Duration(seconds: 4)));
//           }
//         },
//       ),
//     );
//   }
// }
//
// class DeviceScreen extends StatefulWidget {
//   const DeviceScreen({Key? key, required this.device}) : super(key: key);
//
//   final BluetoothDevice device;
//
//   @override
//   State<DeviceScreen> createState() => _DeviceScreenState();
// }
//
// class _DeviceScreenState extends State<DeviceScreen> {
//
//   List<int> _getRandomBytes() {
//     final math = Random();
//     return [
//       math.nextInt(255),
//       math.nextInt(255),
//       math.nextInt(255),
//       math.nextInt(255)
//     ];
//   }
//
//   List<Widget> _buildServiceTiles(List<BluetoothService> services) {
//     return services.map(
//           (service) => ServiceTile(
//             service: service,
//             characteristicTiles: service.characteristics.map((characteristics) => CharacteristicTile(
//                     characteristic: characteristics,
//                     onReadPressed: () => characteristics.read(),
//                     onWritePressed: () async
//                     {
//                       await characteristics.write(hexStringToByteArray('2554530a'), withoutResponse: true);
//                       //await characteristics.read();
//                       mLog.d(characteristics.uuid); //0783b03e-8535-b5a0-7140-a304d2495cba
//                       mLog.d(characteristics.properties);
//                     },
//                     onNotificationPressed: () async
//                     {
//                       if(characteristics.uuid.toString() == '0783b03e-8535-b5a0-7140-a304d2495cb8'){
//                         await characteristics.setNotifyValue(!characteristics.isNotifying);
//                       }
//                       else{
//                         mLog.d('characteristics.uuid.toString() 다르다.');
//                       }
//
//                       mLog.d(characteristics.properties);
//                     },
//                     descriptorTiles: characteristics.descriptors
//                         .map((d) => DescriptorTile(
//                             descriptor: d,
//                             onReadPressed: () => d.read(),
//                             onWritePressed: () => d.write(_getRandomBytes()),
//                           ),
//                         )
//                         .toList(),
//                   ),
//                 )
//                 .toList(),
//           ),
//         )
//         .toList();
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     /// 선택된 디바이스 연결 상태
//     widget.device.state.listen((value){
//       switch (value) {
//         case BluetoothDeviceState.connected:
//           mLog.d('BluetoothDeviceState.connected : connected');
//           break;
//         case BluetoothDeviceState.disconnected:
//           mLog.d('BluetoothDeviceState.connected : disconnected');
//           break;
//         default:
//           mLog.d('BluetoothDeviceState.connected : ${value.toString().substring(21).toUpperCase()}');
//           break;
//       }
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.device.name),
//         // actions: <Widget>[
//         //   StreamBuilder<BluetoothDeviceState>(
//         //     stream: widget.device.state,
//         //     initialData: BluetoothDeviceState.connecting,
//         //     builder: (c, snapshot) {
//         //       VoidCallback? onPressed;
//         //       String text;
//         //       switch (snapshot.data) {
//         //         case BluetoothDeviceState.connected:
//         //           onPressed = () => widget.device.disconnect();
//         //           text = 'DISCONNECT';
//         //           break;
//         //         case BluetoothDeviceState.disconnected:
//         //           onPressed = () => widget.device.connect();
//         //           text = 'CONNECT';
//         //           break;
//         //         default:
//         //           onPressed = null;
//         //           text = snapshot.data.toString().substring(21).toUpperCase();
//         //           break;
//         //       }
//         //       return TextButton(
//         //           onPressed: onPressed,
//         //           child: Text(
//         //             text,
//         //             style: Theme.of(context).primaryTextTheme.button?.copyWith(color: Colors.white),
//         //           ));
//         //     },
//         //   )
//         // ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             StreamBuilder<BluetoothDeviceState>(
//               stream: widget.device.state,
//               initialData: BluetoothDeviceState.connecting,
//               builder: (c, snapshot) => ListTile(
//                 leading: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     snapshot.data == BluetoothDeviceState.connected ? const Icon(Icons.bluetooth_connected) : const Icon(Icons.bluetooth_disabled),
//                     snapshot.data == BluetoothDeviceState.connected
//                         ? StreamBuilder<int>(
//                             stream: rssiStream(),
//                             builder: (context, snapshot) {
//                               return Text(
//                                   snapshot.hasData ? '${snapshot.data}dBm' : '',
//                                   style: Theme.of(context).textTheme.caption);
//                             })
//                         : Text('', style: Theme.of(context).textTheme.caption),
//                   ],
//                 ),
//                 title: Text('Device is ${snapshot.data.toString().split('.')[1]}.'),
//                 subtitle: Text('${widget.device.id}'),
//                 trailing: StreamBuilder<bool>(
//                   stream: widget.device.isDiscoveringServices,
//                   initialData: false,
//                   builder: (c, snapshot) => IndexedStack(
//                     index: snapshot.data! ? 1 : 0,
//                     children: <Widget>[
//                       IconButton(
//                         icon: const Icon(Icons.refresh),
//                         onPressed: () => widget.device.discoverServices(),
//                       ),
//                       const IconButton(
//                         icon: SizedBox(
//                           child: CircularProgressIndicator(
//                             valueColor: AlwaysStoppedAnimation(Colors.grey),
//                           ),
//                           width: 18.0,
//                           height: 18.0,
//                         ),
//                         onPressed: null,
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             StreamBuilder<int>(
//               stream: widget.device.mtu,
//               initialData: 0,
//               builder: (c, snapshot) => ListTile(
//                 title: const Text('MTU Size'),
//                 subtitle: Text('${snapshot.data} bytes'),
//                 trailing: IconButton(
//                   icon: const Icon(Icons.edit),
//                   onPressed: () => widget.device.requestMtu(223),
//                 ),
//               ),
//             ),
//
//             StreamBuilder<List<BluetoothService>>(
//               stream: widget.device.services,
//               initialData: const [],
//               builder: (c, snapshot) {
//
//                 for(var service in snapshot.data!) {
//                   print("Found service ${service.uuid}");
//                   if(service.uuid.toString() == '0783b03e-8535-b5a0-7140-a304d2495cb7'){
//                     for( var characteristic in service.characteristics) {
//                       print("${characteristic.uuid}");
//                       if(characteristic.uuid.toString() == '0783b03e-8535-b5a0-7140-a304d2495cb8'){
//                         mLog.d('write uuid : 0783b03e-8535-b5a0-7140-a304d2495cba 있다.');
//                       }
//                     }
//                   }
//               }
//                 return Column(
//                   children: _buildServiceTiles(snapshot.data!),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Stream<int> rssiStream() async* {
//     var isConnected = true;
//     final subscription = widget.device.state.listen((state) {
//       isConnected = state == BluetoothDeviceState.connected;
//     });
//     while (isConnected) {
//       yield await widget.device.readRssi();
//       await Future.delayed(const Duration(seconds: 1));
//     }
//     subscription.cancel();
//     // Device disconnected, stopping RSSI stream
//   }
//
//   Uint8List hexStringToByteArray(String input) {
//     String cleanInput = remove0x(input);
//
//     int len = cleanInput.length;
//
//     if (len == 0) {
//       return Uint8List(0);
//     }
//     Uint8List data;
//     int startIdx;
//     if (len % 2 != 0) {
//       data = Uint8List((len ~/ 2) + 1);
//       data[0] = digitHex(cleanInput[0]);
//       startIdx = 1;
//     } else {
//       data = Uint8List((len ~/ 2));
//       startIdx = 0;
//     }
//
//     for (int i = startIdx; i < len; i += 2) {
//       data[(i + 1) ~/ 2] =
//           (digitHex(cleanInput[i]) << 4) + digitHex(cleanInput[i + 1]);
//     }
//     return data;
//   }
//
//   remove0x(String hex) => hex.startsWith("0x") ? hex.substring(2) : hex;
//
//   int digitHex(String hex) {
//     int char = hex.codeUnitAt(0);
//     if (char >= '0'.codeUnitAt(0) && char <= '9'.codeUnitAt(0) ||
//         char >= 'a'.codeUnitAt(0) && char <= 'f'.codeUnitAt(0)) {
//       return int.parse(hex, radix: 16);
//     } else {
//       return -1;
//     }
//   }
// }
