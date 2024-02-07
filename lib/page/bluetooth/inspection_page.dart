
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:urine/widgets/button.dart';

import '../../main.dart';
import '../../model/bluetooth_ble.dart';
import '../../model/urine_model.dart';
import '../../providers/count_provider.dart';
import '../../utils/etc.dart';
import '../../utils/frame.dart';

/// 검사 진행
class InspectionPage extends StatefulWidget {
  final BluetoothCharacteristic? writeCharacteristic;
  final BluetoothCharacteristic? notificationCharacteristic;

  const InspectionPage({Key? key,
    required this.writeCharacteristic,
    required this.notificationCharacteristic
  }) : super(key: key);

  @override
  State<InspectionPage> createState() => _InspectionPageState();
}

class _InspectionPageState extends State<InspectionPage> with SingleTickerProviderStateMixin{

  final writeTimeout = Duration(seconds: 5);
  final initStartTime = Duration(seconds: 1);
  final responseTimeout = Duration(seconds: 10);
  StringBuffer sb = StringBuffer('');
  late CountProvider _countProvider;

  bool isRecheck = false;
  late AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // writeCharacteristic to notificationCharacteristic 리스너 등록

    // writeCharacteristic 가 null 아닐경우 검사 진행
    Future.delayed(initStartTime, () async {
      if(widget.writeCharacteristic != null){
        _onValueChangedStreamListener();
        _startInspection();
      } else {
        mLog.i('writeCharacteristic :  null');
      }
    });



    controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )
      ..forward()
      ..addListener(() {
        if (controller.isCompleted) {
          controller.repeat();
        }
      });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _countProvider = Provider.of<CountProvider>(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 70, bottom: 40),
          child: isRecheck?
          AnimatedBuilder(
              builder: (BuildContext context, Widget? child) =>
                  Transform.translate(child: child, offset: Offset(0, 20 * shake(controller.value))),
              animation: controller,
              child: Image.asset('images/error.png', height: 130, width: 130,)
          ) :
          SpinKitCircle(
              size: 100,
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                    decoration: BoxDecoration(
                      color: index.isEven ? Colors.red : Colors.red.shade200,
                    )
                );
              }
          ),
        ),

        Frame.myText(
            text: isRecheck ? '검사 도중 문제가 발생했습니다.\n 다시 시도 하시겠습니까?' : '검사 진행중입니다.\n잠시만 기다려주세요.',
            maxLinesCount: 2,
            fontSize: 1.2,
            fontWeight: FontWeight.w600,
            align: TextAlign.center
        ),

        Visibility(
          visible: isRecheck,
          child: recheckButton(
            text: '재 검사',
            recheckFunction: () => _recheck()),
        )
      ],
    );
  }

  /// 재 검사
  _recheck(){
    setState(() {
      isRecheck = false;
      _startInspection();
    });
  }


  /// 검사 시작
  void _startInspection() async {
    mLog.i('_startInspection');

    try {
      await widget.writeCharacteristic!.write(Etc.hexStringToByteArray('2554530a'), withoutResponse: true)
          .timeout(writeTimeout);
    } on TimeoutException{
      mLog.i('writeCharacteristic TimeoutException!');
    } catch (error) {
      mLog.i('writeCharacteristic error: ${error}!');
    }

    Future.delayed(responseTimeout, (){
      // 수집된 데이터가 없을 경우
      if(sb.isEmpty){
        setState(() {
          isRecheck = true;
        });
      }
    });

  }

  /// characteristic 상태 변화
  /// 데이터 리스너 메소드
  _onValueChangedStreamListener() {
    mLog.i('_onValueChangedStreamListener 등록');
      widget.notificationCharacteristic!.onValueChangedStream.listen((value) {
        // 버퍼에 수신된 데이터를 쌓는다.
        sb.write((String.fromCharCodes(value)).replaceAll('\n', ''));

        // 마지막 비타민 결과 데이터가 들어왔는지 확인한다.
        // 이후 파싱
        if (sb.toString().contains('#A11')) {
          mLog.i('결과 값 replaceAll: ${sb.toString().replaceAll('\n', '')}');
          UrineModel urineModel = UrineModel();
          urineModel.initialization(sb.toString());
          mLog.i(urineModel.toString());

          _countProvider.setUrineModel(urineModel);
          _countProvider.increase();
        };
      });
  }

  /// convert 0-1 to 0-1-0
  double shake(double value) => 2 * (0.5 - (0.5 - Curves.bounceOut.transform(value)).abs());

}
