import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import '../main.dart';
import '../widgets/dialog.dart';
import 'color.dart';
import 'package:intl/intl.dart';

import 'constants.dart';

class Etc{

  /// 스낵바
  static showSnackBar(BuildContext context, {required String msg , required int durationTime}) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            duration: Duration(seconds: durationTime),
            behavior: SnackBarBehavior.floating,
            backgroundColor: mainColor,
            content: Text(msg, textScaleFactor: 0.9),
            ));
    }


  /// 가로 라인 줄
  static solidLine(BuildContext context){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 1.0,
        color: Colors.grey[350],
      ),
    );
  }


  /// 세로 라인 줄
  static solidLineVertical(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        width: 1.5,
        height: 10,
        color: Colors.grey,
      ),
    );
  }

  static solidLineSetting(BuildContext context){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 1.5,
        color: Colors.grey.shade300,
      ),
    );
  }

    
  /// 날짜 ' '기준으로 자르기
  static String  dateParsing(String value) {
    int targetNum = value.indexOf(' ');

    String date = value.substring(0, targetNum);
    String time = value.substring(targetNum, value.length);

    String sum = '$date\n$time';
    return sum;
  }



  /// chart x축 날짜 format(MM/dd)
  static String setDateTime(int duration) {
    final now = DateTime.now();
    final returnDate = now.subtract(Duration(days:duration));

    return DateFormat('MM/dd').format(returnDate);
  }


  static String setDateDuration(int duration) {
    final now = DateTime.now();
    final returnDate = now.subtract(Duration(days:duration));

    return DateFormat('yyyyMMdd').format(returnDate);
  }

  static String setResultDateTime(String dateTime) {
    int year     = int.parse(dateTime.substring(0, 4));
    int month    = int.parse(dateTime.substring(4, 6));
    int day      = int.parse(dateTime.substring(6, 8));
    int hours    = int.parse(dateTime.substring(8, 10));
    int min      = int.parse(dateTime.substring(10, 12));
    int second   = int.parse(dateTime.substring(12));

    final mDateTime = DateTime(year, month, day, hours, min, second);

    return DateFormat('yy년 MM월 dd일 HH시 mm분 ss초').format(mDateTime);
  }

  static String setGroupDateTime(String dateTime) {
    int year     = int.parse(dateTime.substring(0, 4));
    int month    = int.parse(dateTime.substring(4, 6));
    int day      = int.parse(dateTime.substring(6, 8));

    final mDateTime = DateTime(year, month, day, 0, 0, 0, 0 ,0);

    return DateFormat('yy/MM/dd').format(mDateTime);
  }

  static String setSearchDateView(String dateTime) {
    int year     = int.parse(dateTime.substring(0, 4));
    int month    = int.parse(dateTime.substring(4, 6));
    int day      = int.parse(dateTime.substring(6, 8));

    final mDateTime = DateTime(year, month, day, 0, 0, 0, 0 ,0);

    return DateFormat('yyyy. MM. dd').format(mDateTime);
  }


  /// List<int> to String('A,B,C...')
  static String intListToString(List<int> list){
    return list.map((item) => item)
        .toList()
        .join(',');
  }


  /// map() print
  static void getValuesFromMap(Map map) {

    // Get all values
    print('\n-----------------------');
    print('Map Get values:');
    map.entries.forEach((entry){
      mLog.d('${entry.key} : ${entry.value}');
    });
    print('-----------------------\n');
  }

  /// font size fixation
  static MediaQueryData getScaleFontSize(BuildContext context, {double fontSize = 1.0}){
    final mqData = MediaQuery.of(context);
    return mqData.copyWith(textScaleFactor: fontSize);
  }


  static String itemNameToDataType(String value){
    switch(value){
      case '잠혈':  return 'DT01';
      case '빌리루빈':  return 'DT02';
      case '우로빌리노겐':  return 'DT03';
      case '케톤체':  return 'DT04';
      case '단백질':  return 'DT05';
      case '아질산염':  return 'DT06';
      case '산성도':  return 'DT07';
      case '포도당':  return 'DT08';
      case '비중':  return 'DT09';
      case '백혈구':  return 'DT10';
      case '비타민':  return 'DT11';
      default: return 'DT01';
    }
  }

  static String dataTypeToItemName(String value){
    switch(value){
      case 'DT01':  return '잠혈';
      case 'DT02':  return '빌리루빈';
      case 'DT03':  return '우로빌리노겐';
      case 'DT04':  return '케톤체';
      case 'DT05':  return '단백질';
      case 'DT06':  return '아질산염';
      case 'DT07':  return '산성도';
      case 'DT08':  return '포도당';
      case 'DT09':  return '비중';
      case 'DT10':  return '백혈구';
      case 'DT11':  return '비타민';
      default: return '-';
    }
  }
  /// 홈 화면에 상담진행률에 따른 이미지 설정
  static String setProgressImage(int allProgress) {
    if(allProgress == 0){
      return 'images/progress_0.png';
    }
    else if(allProgress <= 15){
      return 'images/progress_10.png';
    }
    else if(allProgress <= 25){
      return 'images/progress_20.png';
    }
    else if(allProgress <= 35){
      return 'images/progress_30.png';
    }
    else if(allProgress <= 45){
      return 'images/progress_40.png';
    }
    else if(allProgress <= 55){
      return 'images/progress_50.png';
    }
    else if(allProgress <= 65){
      return 'images/progress_60.png';
    }
    else if(allProgress <= 75){
      return 'images/progress_70.png';
    }
    else if(allProgress <= 85){
      return 'images/progress_80.png';
    }
    else if(allProgress <= 95){
      return 'images/progress_90.png';
    }
    else if(allProgress == 100){
      return 'images/progress_100.png';
    }else{
      return 'images/progress_0.png';
    }

  }

  /// 상담메뉴 사용할 수 있는 시간 설정
  /// 데드라인 안쪽이면 true
  /// 데드라인을 넘으면 false
  static bool checkDeadline() {
    final now = DateTime.now();
    final deadline = DateTime(2022, 12, 12, 23, 59, 0, 0 ,0);
    mLog.d('Deadline ${!deadline.isBefore(now)}');
    return !deadline.isBefore(now);
  }


  static void handleExceptionError(BuildContext context, String error){
    String text;
    print('catch : $error');

    if(error.contains('response'))
    {
      mLog.e('[Error]  response error!');
      text = MESSAGE_ERROR_RESPONSE;
    }
    else if(error.contains('connect'))
    {
      mLog.e('[Error] connect timeout!');
      text = MESSAGE_ERROR_CONNECT;
    }
    else if(error.contains('receive'))
    {
      mLog.e('[Error] : receive timeout!');
      text = MESSAGE_ERROR_RECEIVE;
    }
    else{
      mLog.e('ChatBot : unknown error');
      text = MESSAGE_ERROR_UNKNOWN;
    }

    /// 에러 발생 시  다이얼로그를 띄워준다.
    CustomDialog.showDioDialog(
        '오류!',
        text,
        context,
        onPositive: () { Navigator.pop(context); },
    );
  }


  /// Change hex string of [%TS] to byte data
  static Uint8List hexStringToByteArray(String input) {
    String cleanInput = remove0x(input);

    int len = cleanInput.length;

    if (len == 0) {
      return Uint8List(0);
    }
    Uint8List data;
    int startIdx;
    if (len % 2 != 0) {
      data = Uint8List((len ~/ 2) + 1);
      data[0] = digitHex(cleanInput[0]);
      startIdx = 1;
    } else {
      data = Uint8List((len ~/ 2));
      startIdx = 0;
    }

    for (int i = startIdx; i < len; i += 2) {
      data[(i + 1) ~/ 2] =
          (digitHex(cleanInput[i]) << 4) + digitHex(cleanInput[i + 1]);
    }
    return data;
  }

  static remove0x(String hex) => hex.startsWith("0x") ? hex.substring(2) : hex;

  static int digitHex(String hex) {
    int char = hex.codeUnitAt(0);
    if (char >= '0'.codeUnitAt(0) && char <= '9'.codeUnitAt(0) ||
        char >= 'a'.codeUnitAt(0) && char <= 'f'.codeUnitAt(0)) {
      return int.parse(hex, radix: 16);
    } else {
      return -1;
    }
  }


  /// GATT SERVICE 찾기
  static BluetoothService? findBluetoothService(List<BluetoothService> gattService){
    BluetoothService? applicableService;

    for(var service in gattService) {
      if(service.uuid.toString() == BLE_GATT_UUID_GATT_SERVICE){
        applicableService = service;
      }
    }
    return applicableService;
  }

  /// Characteristic 찾기
  static BluetoothCharacteristic? findBluetoothCharacteristic(BluetoothService gattService, String findCharacteristic){
    BluetoothCharacteristic? applicableCharacteristics;

    for(var characteristics in gattService.characteristics) {
      if(characteristics.uuid.toString() == findCharacteristic){
        applicableCharacteristics = characteristics;
      }
    }

    return applicableCharacteristics;
  }
}

