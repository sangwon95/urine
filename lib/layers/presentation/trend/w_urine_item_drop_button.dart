

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:urine/common/common.dart';

import '../widget/style_text.dart';

/// 유린 항목 아이템 DropButton
class UrineNameDropButton extends StatelessWidget {
  final String selectedUrineName;
  final Function(String?) onChanged;

  const UrineNameDropButton({
    super.key,
    required this.selectedUrineName,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        hint: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: StyleText(
            text: selectedUrineName,
            size: AppDim.fontSizeSmall,
            color: AppColors.blackTextColor,
            fontWeight: AppDim.weight500,
          ),
        ),
        items: AppConstants.urineNameList.map((String item) =>
            DropdownMenuItem<String>(
            value: item,
            child: StyleText(
              text: item,
              size: AppDim.fontSizeSmall,
              overflow: TextOverflow.ellipsis,
              color:  AppColors.blackTextColor,
              fontWeight: AppDim.weight500,
            )
        )).toList(),
        value: selectedUrineName,
        onChanged: onChanged,
        alignment: AlignmentDirectional.center,
        buttonStyleData: buttonStyle, // 클릭할 버튼 스타일
        iconStyleData: iconStyle, // 우측 아이콘 스타일
        dropdownStyleData: dropdownStyle, // 클릭 후 아래에 표시될 dropdown button 스타일
        menuItemStyleData: menuItemStyle, // dropdown button 아이템 스타일
      ),
    );
  }


  /// 클릭할 버튼 스타일
  get buttonStyle => ButtonStyleData(
    height: AppConstants.dropButtonHeight,
    width: 130,
    padding: const EdgeInsets.only(left: 5, right: 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(AppConstants.radius),
      border: Border.all(color: AppColors.brightGrey),
      color: AppColors.white,
    ),
  );


  /// 우측 아이콘 스타일
  get iconStyle => const IconStyleData(
    icon: Icon(Icons.keyboard_arrow_down_rounded),
    iconSize: AppDim.iconSmall,
  );


  /// 클릭 후 아래에 표시될 dropdown button 스타일
  get dropdownStyle => DropdownStyleData(
    maxHeight: 200,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
    ),
    offset: const Offset(0, 0),
    scrollbarTheme: ScrollbarThemeData(
      radius: const Radius.circular(20),
      thickness: MaterialStateProperty.all(3),
      thumbVisibility: MaterialStateProperty.all(true),
    ),
  );


  /// dropdown button 아이템 스타일
  get menuItemStyle => const MenuItemStyleData(
    height: 40,
    padding: EdgeInsets.only(left: 14, right: 14),
  );
}