import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:urine/common/common.dart';
import 'package:urine/layers/presentation/widget/style_text.dart';

/// 날짜 선택 피커
class DatePickerBottomSheet extends StatelessWidget {
  final Function(DateTime) onSubmit;

  const DatePickerBottomSheet({
    super.key,
    required this.onSubmit,
  });

  int get minimumYear => 1900;
  String get cancelText => '취소';
  String get summitText => '확인';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime selectDate = DateTime.now();

    return Container(
        height: size.height * 0.4,
        padding: AppDim.marginLarge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: AppConstants.radius,
              topRight: AppConstants.radius,
          ),
          color: AppColors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Nav.doPop(context),
                  child: StyleText(
                    text: cancelText,
                    size: AppDim.fontSizeMedium,
                    fontWeight: AppDim.weightBold,
                    color: AppColors.blackTextColor,

                  ),
                ),
                TextButton(
                  onPressed: () {
                    Nav.doPop(context);
                    onSubmit(selectDate);
                  },
                  child: StyleText(
                    text: summitText,
                    size: AppDim.fontSizeMedium,
                    fontWeight: AppDim.weightBold,
                    color: AppColors.blackTextColor,
                  ),
                )
              ],
            ),
            const Gap(AppDim.xSmall),

            SizedBox(
              height: size.height * 0.27,
              child: CupertinoDatePicker(
                minimumYear: minimumYear,
                maximumYear: DateTime.now().year,
                initialDateTime: DateTime.now(),
                maximumDate: DateTime.now(),
                mode: CupertinoDatePickerMode.date,
                use24hFormat: true,
                onDateTimeChanged: (date) => selectDate = date,
              ),
            ),
          ],
        ),
    );
  }
}
