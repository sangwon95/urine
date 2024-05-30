

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:urine/common/common.dart';

import '../../widget/style_text.dart';

class GenderDropdownButton extends StatelessWidget {
  final String? selectedValue;
  final Function(String?) onChanged;

  const GenderDropdownButton({
    super.key,
    this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 3),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          hint: StyleText(
            text: selectedValue ?? '성별을 선택해주세요.',
            size: AppDim.fontSizeSmall,
            color: AppColors.greyTextColor,
          ),
          items: ['남자','여자'].map((String item) => DropdownMenuItem<String>(
              value: item,
              child: StyleText(
                text: item,
                size: AppDim.fontSizeSmall,
                overflow: TextOverflow.ellipsis,
                color: AppColors.blackTextColor,
              )
          )).toList(),
          value: selectedValue,
          onChanged: onChanged,
          alignment: AlignmentDirectional.center,
          buttonStyleData: ButtonStyleData(
            height: AppConstants.signupTextFieldHeight,
            padding: const EdgeInsets.only(left: 8, right: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(AppConstants.radius),
              color: AppColors.signupTextFieldBg,
            ),
          ),
          iconStyleData: IconStyleData(
            icon: const Icon(
              Icons.arrow_drop_down_outlined,
            ),
            iconSize: 25,
            iconEnabledColor: AppColors.greyTextColor,
            iconDisabledColor: AppColors.greyTextColor,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.signupTextFieldBg,
            ),
            offset: const Offset(0, 0),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(20),
              thickness: MaterialStateProperty.all(3),
              thumbVisibility: MaterialStateProperty.all(true),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.only(left: 14, right: 14),
          ),
        ),
      ),
    );
  }
}