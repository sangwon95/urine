
import 'package:flutter/material.dart';
import 'package:urine/common/util/scale_font_size.dart';
import 'package:urine/layers/presentation/auth/login/v_login.dart';

import '../../../../common/common.dart';

class LoginTextField extends StatelessWidget {

  final LoginInputType type;
  final TextEditingController controller;

  const LoginTextField({
    super.key,
    required this.type,
    required this.controller,
  });

  String get passHint => '비밀번호를 입력해주세요.';
  String get idHint => '아이디를 입력해주세요.';

  @override
  Widget build(BuildContext context) {
    return Container(
        height: AppConstants.textFieldHeight,
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.symmetric(horizontal: AppDim.large),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(AppConstants.mediumRadius),
          border: Border.all(
              color: Colors.grey.shade300,
              width: AppConstants.borderLightWidth,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: MediaQuery(
                data: getScaleFontSize(context),
                child: TextField(
                  autofocus: false,
                  obscureText: type == LoginInputType.password
                      ? true
                      : false,
                  controller: controller,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                      color: Colors.black, decorationThickness: 0),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                     contentPadding: const EdgeInsets.only(top: 13),
                    prefixIcon: Icon(type == LoginInputType.id
                        ? Icons.account_circle_outlined
                        : Icons.key_sharp,
                        color: AppColors.primaryColor,
                    ),
                      hintText: type == LoginInputType.password
                          ? passHint
                          : idHint,
                      hintStyle: const TextStyle(
                        fontSize: AppDim.fontSizeSmall,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}



/// 로그인 정보 입력 필드를 만드는 위젯을 생성하는 함수.
///
/// [hint]: 입력 필드 내에 나타낼 힌트 텍스트.
/// [inputType]: 입력 필드의 유형을 나타내는 열거형(LoginInput) 값. 비밀번호 입력 여부 등을 결정하는 데 사용됩니다.
/// [controller]: 입력 필드의 텍스트 상태를 관리하는 데 사용되는 컨트롤러.
///
/// return value: 위젯(Widget)으로서 전화번호, 인증번호 입력 필드를 포함하는 컨테이너를 반환합니다.
/// TODO: 입력시 띄워쓰기는 지워줘야된다.
// Widget buildLoginTextField({
//   required String hint,
//   required LoginInput inputType,
//   required TextEditingController controller,
// }) {
  //return
// }
//
// /// 로그인 버튼
// Widget buildLoginButton() {
//   return InkWell(
//     onTap: () => _viewModel.handleLogin(),
//     child: Container(
//         height: 55,
//         width: double.infinity,
//         margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//         decoration: BoxDecoration(
//             borderRadius: const BorderRadius.all(Radius.circular(30)),
//             border: Border.all(color: Colors.white, width: 2.0)),
//         child: Center(
//           child: StyleText(
//               text: '로그인',
//               color: AppColors.whiteTextColor,
//               size: AppDim.fontSizeMedium,
//               fontWeight: AppDim.weightBold),
//         )),
//   );
// }