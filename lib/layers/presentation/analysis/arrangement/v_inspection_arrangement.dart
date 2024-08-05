import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:urine/common/common.dart';
import 'package:urine/layers/presentation/analysis/arrangement/w_inspection_checkbox.dart';
import 'package:urine/layers/presentation/widget/default_button.dart';
import 'package:urine/layers/presentation/widget/scaffold/frame_scaffold.dart';
import 'package:urine/layers/presentation/widget/style_text.dart';

import '../../../model/enum/arrangement_type.dart';
import '../bluetooth/v_bluetooth_connection.dart';
import 'vm_inspection_arrangement.dart';
import 'w_inspection_header.dart';


/// 소변 검사 준비 화면
class InspectionArrangementView extends StatefulWidget {
  const InspectionArrangementView({super.key});

  @override
  State<InspectionArrangementView> createState() =>
      _InspectionArrangementViewState();
}

class _InspectionArrangementViewState extends State<InspectionArrangementView>{
  String get title => '소변 검사';

  String get startText => '검사 진행';

  List<String> get checkList => [
        '✓ 모든 체크박스가 체크 되면 자동으로 검사가 진행됩니다.',
        '✓ 검사기 전원을 키고 체크박스를 클릭해주세요.',
        '✓ 블루투스를 켜면 자동으로 체크됩니다.',
      ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => InspectionArrangementViewModel(),
      child: FrameScaffold(
        appBarTitle: title,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: AppConstants.viewPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 검사 준비 헤더
                    const Gap(AppDim.large),
                    const InspectionHeader(),

                    /// 검사 전 체크 사항(블루투스ON, 검사기ON)
                    const Gap(AppDim.xLarge),
                    Consumer<InspectionArrangementViewModel>(
                      builder: (context, provider, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            /// 블루투스 ON/OFF 상태 확인
                            Expanded(
                              child: InspectionCheckBox(
                                type: ArrangementType.bluetooth,
                                isCheckBox: provider.isBluetoothActive,
                              ),
                            ),

                            /// 검사기 ON/OFF 상태 확인
                            const Gap(AppDim.large),
                            Expanded(
                              child: InspectionCheckBox(
                                type: ArrangementType.device,
                                isCheckBox: provider.isDeviceActive,
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    /// 체크리스트
                    const Gap(AppDim.large),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StyleText(
                          text: checkList[0],
                          color: AppColors.greyTextColor,
                          softWrap: true,
                          maxLinesCount: 2,
                        ),

                        const Gap(AppDim.xSmall),
                        StyleText(
                          text: checkList[1],
                          color: AppColors.greyTextColor,
                          softWrap: true,
                          maxLinesCount: 2,
                        ),

                        const Gap(AppDim.xSmall),
                        StyleText(
                          text: checkList[2],
                          color: AppColors.greyTextColor,
                          softWrap: true,
                          maxLinesCount: 2,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),

            /// 검사 진행 버튼
            Consumer<InspectionArrangementViewModel>(
              builder: (context, provider, child) {
                return  Visibility(
                  visible: provider.visibleStartButton,
                  child: DefaultButton(
                      btnName: startText,
                      onPressed: () => {
                        Nav.doPop(context), // 검사전 준비 화면 pop
                        Nav.doPush(context, const BluetoothConnectionView())
                      },
                  ),
                );
              },
            ),
            Platform.isAndroid
                ? const Gap(AppDim.large)
                : const Gap(AppDim.xXLarge),
          ],
        ),
      ),
    );
  }
}
