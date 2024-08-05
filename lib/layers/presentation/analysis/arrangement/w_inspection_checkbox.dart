import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:provider/provider.dart';
import 'package:urine/common/common.dart';
import 'package:urine/layers/presentation/analysis/arrangement/vm_inspection_arrangement.dart';
import 'package:urine/layers/presentation/widget/frame_container.dart';
import 'package:urine/layers/presentation/widget/style_text.dart';

import '../../../model/enum/arrangement_type.dart';

class InspectionCheckBox extends StatelessWidget {
  final ArrangementType type;
  final bool isCheckBox;

  const InspectionCheckBox({
    super.key,
    required this.type,
    required this.isCheckBox,
  });

  @override
  Widget build(BuildContext context) {
    return FrameContainer(
      backgroundColor: AppColors.greyBoxBg,
      child: InkWell(
        onTap: () => {
          if (type == ArrangementType.device){
            context.read<InspectionArrangementViewModel>().onChangedDevice(context)
          }
        },
        child: Column(
          children: [
            /// 체크 박스
            Padding(
              padding: const EdgeInsets.only(bottom: AppDim.large),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MSHCheckbox(
                    size: 20,
                    value: isCheckBox,
                    colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                      checkedColor: AppColors.primaryColor,
                    ),
                    style: MSHCheckboxStyle.stroke,
                    onChanged: (selected) {
                      if(type == ArrangementType.device) {
                        context.read<InspectionArrangementViewModel>()
                            .onChangedDevice(context);
                      }
                    },
                  ),
                  const Gap(AppDim.xSmall),
                  StyleText(
                      text: type.stateOn,
                      fontWeight: AppDim.weightBold,
                      color: AppColors.primaryColor,
                      size: AppDim.fontSizeSmall,
                  )
                ],
              ),
            ),


            Image.asset(
              type.image,
              height: AppDim.imageSmallMedium,
              width: AppDim.imageSmallMedium,
            ),
            const Gap(AppDim.large),

            StyleText(
              text: type.recommend,
              fontWeight: AppDim.weightBold,
              color: AppColors.greyTextColor,
              size: AppDim.fontSizeSmall,
              align: TextAlign.center,
              maxLinesCount: 2,
            )
          ],
        ),
      ),
    );
  }
}
