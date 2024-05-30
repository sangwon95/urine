
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:urine/common/common.dart';
import 'package:urine/layers/presentation/analysis/bluetooth/vm_bluetooth_connection.dart';
import 'package:urine/layers/presentation/widget/default_button.dart';
import 'package:urine/layers/presentation/widget/style_text.dart';

import '../../widget/scaffold/frame_scaffold.dart';

/// 블루투스 연결 화면
/// TODO: 1.디자인 2.측정데이터 서버에 저장
class BluetoothConnectionView extends StatefulWidget {
  const BluetoothConnectionView({super.key});

  @override
  State<BluetoothConnectionView> createState() => _BluetoothConnectionViewState();
}

class _BluetoothConnectionViewState extends State<BluetoothConnectionView> {
  String get title => '소변 검사';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => BluetoothConnectionViewModel(context),
      child: FrameScaffold(
        appBarTitle: title,
        gradient: AppConstants.gradient,
        body: Consumer<BluetoothConnectionViewModel>(
          builder: (context, provider, child) {
            return  Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// 프로그래스바
                  progressView(provider.imagePath),

                  /// 블루투스 상태 텍스트
                  const Gap(AppDim.xLarge),
                  StyleText(
                    text: provider.stateText,
                    fontWeight: AppDim.weight500,
                    softWrap: true,
                    maxLinesCount: 2,
                    align: TextAlign.center,
                  ),

                  /// 에러 발생시 활성화되는 버튼(재검색, 재연결, 재검사)
                  const Gap(AppDim.xXLarge),
                  const Gap(AppDim.xXLarge),
                  Visibility(
                    visible: provider.isErrorWidget,
                    child: DefaultButton(
                      btnName: provider.buttonText,
                      onPressed: provider.onPressedError,
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  progressView(String imagePath) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: AppConstants.borderLightRadius,
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(AppDim.large),
        child: Image.asset(imagePath,
            width: 80,
            height: 80,
        ),
      ),
    );
  }
}


// _buildSearchView() {
//   return Container(
//         width: double.infinity,
//           padding: const EdgeInsets.fromLTRB(15, 30, 15, 10),
//           child: AvatarGlow(
//             glowColor: mainColor,
//             endRadius: 130.0,
//             duration: Duration(milliseconds: 2000),
//             repeat: isShowGlows,
//             showTwoGlows: isShowGlows,
//             animate: isShowGlows,
//             repeatPauseDuration: Duration(milliseconds: 200),
//             child: Material(     // Replace this child with your own
//               elevation: 4.0,
//               shape: CircleBorder(),
//               child: CircleAvatar(
//                 backgroundColor: Colors.grey[100],
//                 child: Icon(Icons.bluetooth, color: Colors.blue, size: 50),
//                 radius: 45.0,
//               ),
//             ),
//           ),
//       );
// }