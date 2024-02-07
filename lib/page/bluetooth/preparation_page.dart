
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

import '../../utils/bluetooth_util.dart';
import '../../utils/frame.dart';
import '../../widgets/button.dart';

/// 검사 준비
class PreparationPage extends StatefulWidget {
  final double mWidth;
  const PreparationPage({Key? key, required this.mWidth}) : super(key: key);

  @override
  State<PreparationPage> createState() => _PreparationPageState();
}

class _PreparationPageState extends State<PreparationPage> {

  /// step 0: 검사 준비
  bool isDevice         = false; // 디바이스 상태
  bool isBluetooth      = false; // 블루투스 상태
  String deviceState    = '검사기 OFF'; // 디바이스 상태 Text
  String bluetoothState = '블루투스 OFF'; // 블루투스 상태 Text

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bluetoothStateLister(); // BluetoothState 리스너 등록
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      margin: EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:
            [
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                elevation: 4,
                child: Container(
                  height: 230,
                  width: (widget.mWidth/2) - 18,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.bluetooth, color: Colors.blue, size: 80),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Frame.myText(
                          text: '블루투스 전원을 활성화 해주세요.',
                          fontSize: 1.0,
                          maxLinesCount: 2,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 5, top: 10),
                        child: Row(
                          children: [
                            MSHCheckbox(
                              size: 25,
                              value: isBluetooth,
                              colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                                checkedColor: Colors.blue,
                              ),
                              style: MSHCheckboxStyle.stroke,
                              onChanged: (selected) { },
                            ),
                            SizedBox(width: 10),
                            Frame.myText(
                                text: bluetoothState,
                                fontWeight: FontWeight.w600,
                                color: isBluetooth ? Colors.blue : Colors.grey,
                                fontSize: 1.0
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                child: Container(
                  height: 230,
                  width: (widget.mWidth/2) - 18,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.devices, color: Colors.blue, size: 80),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Frame.myText(
                          text: '검사기가 켜져있는지 확인 해주세요.',
                          fontSize: 1.0,
                          maxLinesCount: 2,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, top: 10),
                        child: Row(
                          children: [
                            MSHCheckbox(
                              size: 25,
                              value: isDevice,
                              colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                                checkedColor: Colors.blue,
                              ),
                              style: MSHCheckboxStyle.stroke,
                              onChanged: (selected) {
                                setState(()
                                {
                                  isDevice = selected;
                                  deviceState = '검사기 ON';
                                });
                              },
                            ),
                            SizedBox(width: 10),
                            Frame.myText(
                                text: deviceState,
                                fontWeight: FontWeight.w600,
                                color: isDevice ? Colors.blue : Colors.grey,
                                fontSize: 1.0
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),


          Padding(
            padding: const EdgeInsets.fromLTRB(8, 15, 8, 40),
            child: Frame.myText(
              text: '✓ 모든 체크박스가 체크 되어 있어야됩니다.\n✓ 블루투스를 켜시면 자동으로 체크됩니다.',
              fontSize: 0.95,
              maxLinesCount: 2,
              fontWeight: FontWeight.w600,
              color: Colors.redAccent,
            ),
          ),

          // Visibility (
          //     visible: isDevice&&isBluetooth,
          //     child: PreparationToSearchButton(context: context, text: '준비 완료')
          // )
        ],
      ),
    );;
  }

  /// 시스템 블루투스 on/off 상태 리스너
  _bluetoothStateLister(){
    FlutterBluePlus.adapterState.listen((value){
      if (value == BluetoothAdapterState.off) {
        setState((){
          isBluetooth = false;
          bluetoothState = '블루투스 OFF';
        });
      }

      else if(value == BluetoothAdapterState.on){
        setState((){
          isBluetooth = true;
          bluetoothState = '블루투스 ON';
        });
      }
    });
  }
}