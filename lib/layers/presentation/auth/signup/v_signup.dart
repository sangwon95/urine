import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:urine/common/common.dart';
import 'package:urine/common/constant/app_dimensions.dart';
import 'package:urine/layers/presentation/auth/signup/vm_signup.dart';
import 'package:urine/layers/presentation/auth/signup/w_signup_button.dart';
import 'package:urine/layers/presentation/auth/signup/w_signup_row_form.dart';
import 'package:urine/layers/presentation/auth/signup/w_signup_textfield.dart';
import 'package:urine/layers/presentation/auth/signup/w_terms_use.dart';
import 'package:urine/layers/presentation/widget/scaffold/frame_scaffold.dart';
import 'package:urine/layers/presentation/widget/w_dotted_line.dart';

import '../../../model/enum/signup_type.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => SignupViewModel(),
      child: Consumer<SignupViewModel>(
        builder: (context, provider, child) {
          return  FrameScaffold(
            isKeyboardHide: true,
            appBarTitle: Texts.signupLabel,
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppDim.medium),
                    child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                          [
                            const Gap(AppDim.large),

                            /// 아이디 입력
                            SignupRowForm(
                              title: SignupType.id.title,
                              child: SignupTextField(
                                type: SignupType.id,
                                controller: provider.idController,
                              ),
                            ),
                            const DottedLine(mWidth: double.infinity),

                            /// 비밀번호 입력
                            SignupRowForm(
                              title: SignupType.pass.title,
                              child: SignupTextField(
                                type: SignupType.pass,
                                controller: provider.passController,
                              ),
                            ),
                            SignupRowForm(
                              title: SignupType.pass2.title,
                              child: SignupTextField(
                                type: SignupType.pass2,
                                controller: provider.pass2Controller,
                              ),
                            ),
                            const DottedLine(mWidth: double.infinity),

                            /// 닉네임 입력
                            SignupRowForm(
                              title: SignupType.nickname.title,
                              child: SignupTextField(
                                type: SignupType.nickname,
                                controller: provider.nickNameController,
                              ),
                            ),

                            const DottedLine(mWidth: double.infinity),
                            const Gap(AppDim.large),

                            /// 이용약관
                            Consumer<SignupViewModel>(
                              builder: (context, provider, child) {
                                return TermsUse(
                                  isCheckedInfo: provider.isCheckedInfo,
                                  isCheckedService: provider.isCheckedService,
                                  onChangedInfo: (value) => provider.isCheckedInfo = value,
                                  onChangedService: (value) => provider.isCheckedService = value,
                                  showTerms: () => provider.showTermsDialog(context),
                                );
                              },
                            ),
                          ],
                        ),
                  ),
                  const Gap(AppDim.xXLarge),


                  /// 회원가입 버튼
                  Visibility(
                    visible: provider.isAllChecked,
                    child: SignUpButton(
                      onPressed: () => provider.signup(context),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}





//const DottedLine(mWidth: double.infinity),

/// 생년월일 입력
// SignupRowForm(
//   title: SignupType.birthdate.title,
//   child: Consumer<SignupViewModel>(
//     builder: (context, provider, child) {
//       return BirthDateBox(
//         birthDate: provider.birthdate,
//         onTap: () => provider.showDataPickerBottomSheet(context),
//       );
//     },
//   ),
// ),
// const DottedLine(mWidth: double.infinity),
//
// /// 성별 선택
// SignupRowForm(
//   title: SignupType.gender.title,
//   child: Consumer<SignupViewModel>(
//     builder: (context, provider, child) {
//       return GenderDropdownButton(
//         selectedValue: provider.gender,
//         onChanged: (gender) => provider.gender = gender,
//       );
//     },
//   ),
// ),