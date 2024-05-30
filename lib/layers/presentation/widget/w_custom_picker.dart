

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:urine/common/common.dart';
import 'package:urine/common/constant/app_dimensions.dart';
import 'package:urine/layers/presentation/widget/style_text.dart';


/// CustomPicker class
class CustomPicker{
  var tempData;

  /// BottomSheet Widget
  /// @param pickerModel : PickerModel
  showBottomSheet(PickerData pickerData){
    tempData  = pickerData.itemList[0];

    showModalBottomSheet(context: pickerData.context, builder: (context) {
      return Container(
        height: 250,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 상단 버튼
            Padding(
                padding: const EdgeInsets.only(left: 12, top: 12, right: 12),
                child: _rowBottomSheetTopBtn(context, pickerData.callback)
            ),

            // 하단 picker
            _commonCupertinoPicker(pickerData.indexInitialValue, pickerData.itemList)
          ],
        ),
      );
    });
  }


  /// BottomSheet 상단 버튼
  /// Row [ 취소, 확인 ]
  /// @param context : Widget position
  /// @param Function() : callback 함수 - picker 에서 선택된 데이터가 콜백 된다.
  /// @param selectedData  : 임시로 선택된 데이터 저장 변수
  /// @return : Row()
  _rowBottomSheetTopBtn(BuildContext context, Function(dynamic ageData) callback){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          child: StyleText(
              text: '취소',
              size: AppDim.fontSizeLarge,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold),
          onPressed: () {
            Navigator.pop(context);
            print('>>>> [bottomSheet 취소]');
          },
        ),

        TextButton(
          child: StyleText(
              text: '확인',
              size: AppDim.fontSizeLarge,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold),
          onPressed: () {
            Navigator.pop(context);
            callback(tempData);
          },
        )
      ],
    );
  }


  /// BottomSheet picker
  /// @param indexInitialValue : 각 index 의 초기 값 [ ex) 나이 10살부터 .. indexInitialValue => 10 ]
  /// @param itemList : picker 에 뿌려줄  리스트
  /// @return Expanded()
  _commonCupertinoPicker(dynamic indexInitialValue, List<dynamic> itemList){
    return Expanded(
        child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  child: Container(
                      height: 160,
                      child: CupertinoPicker(
                          itemExtent: 40,
                          onSelectedItemChanged: (int index) {
                            tempData = itemList[index];
                          },
                          children: itemList.map((e) => Center(child: Text(itemList.length == 10? '$e시간': '$e걸음', textScaleFactor: 0.95))).toList())
                  ))])
    );
  }

}

/// picker data class
class PickerData{
  dynamic indexInitialValue;       // 초기 값(위치)
  List<dynamic> itemList;          // inout Type: [int or String]
  BuildContext context;            // Widget position
  Function(dynamic data) callback; // callback 함수 - picker 에서 선택된 데이터가 콜백 된다.

  PickerData(this.indexInitialValue, this.itemList, this.context, this.callback);

}