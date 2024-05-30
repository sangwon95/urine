import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:urine/common/common.dart';
import 'package:urine/layers/presentation/setting/password/vm_change_password.dart';
import 'package:urine/layers/presentation/setting/password/w_change_pass_button.dart';
import 'package:urine/layers/presentation/widget/scaffold/frame_scaffold.dart';
import 'package:urine/layers/presentation/widget/style_text.dart';

import '../../../model/enum/signup_type.dart';
import '../../auth/signup/w_signup_row_form.dart';
import '../../auth/signup/w_signup_textfield.dart';
import '../../widget/w_dotted_line.dart';


enum PasswordStatusType {
  beforpass('현재 비밀번호', '아이디를 입력해주세요.'),
  newpass('새 비밀번호', '특수,소문자,숫자 포함 7~15자'),
  newpass2('새 비밀번호 확인', '특수,소문자,숫자 포함 7~15자');

  const PasswordStatusType(this.title, this.hint);

  final String title;
  final String hint;
}

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {

  String get title => '비밀번호 변경';
  String get guideText => '개인정보의 기술적•관리적 보호조치 기준에\n 의거하여,개인 정보 취급자는 6개월에 한 번씩\n비밀번호를 변경해야 합니다.';

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
      create: (BuildContext context) => ChangePasswordViewModel(),
      child: Consumer<ChangePasswordViewModel>(
        builder: (context, provider, child) {
          return  FrameScaffold(
              appBarTitle: title,
              isKeyboardHide: true,
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppDim.medium),
                  child: Column(
                      children:
                      [
                        const Gap(AppDim.xLarge),

                        SignupRowForm(
                          title: PasswordStatusType.beforpass.title,
                          child: SignupTextField(
                            type: SignupType.pass,
                            controller: provider.beforePassController,
                          ),
                        ),

                        const DottedLine(mWidth: double.infinity),

                        /// 비밀번호 입력
                        SignupRowForm(
                          title: PasswordStatusType.newpass.title,
                          child: SignupTextField(
                            type: SignupType.pass,
                            controller: provider.newPassController,
                          ),
                        ),
                        SignupRowForm(
                          title: PasswordStatusType.newpass2.title,
                          child: SignupTextField(
                            type: SignupType.pass,
                            controller: provider.newPass2Controller,
                           ),
                        ),
                        const DottedLine(mWidth: double.infinity),

                        const Gap(AppDim.medium),
                        StyleText(
                          text: guideText,
                          softWrap: true,
                          size: AppDim.fontSizeSmall,
                          align: TextAlign.center,
                          maxLinesCount: 3,
                        ),
                        const Gap(AppDim.xXLarge),

                        /// 비밀번호 변경 버튼
                        ChangePasswordButton(
                          onPressed: () => provider.changePassword(context),
                        ),
                        const Gap(AppDim.xXLarge),

                      ]
                  ),
                ),
              )
          );
        },
      ),
    );
  }
}
