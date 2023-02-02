import 'package:flutter/material.dart';
import '../../main.dart';
import '../../utils/color.dart';
import '../../utils/constants.dart';
import '../../utils/edit_controller.dart';
import '../../utils/etc.dart';
import '../../utils/frame.dart';
import '../../widgets/button.dart';
import '../../widgets/text_field.dart';

/// 비밀번호 변경 화면
class PassChangePage extends StatefulWidget {

  final VoidCallback editInfoCompleteMsg;
  PassChangePage(this.editInfoCompleteMsg); // 비밀번호 변경 완료 callback

  @override
  _PassChangePageState createState() => _PassChangePageState();
}

class _PassChangePageState extends State<PassChangePage> {

  final String title = '비밀번호 변경';
  final passwordEdit = PasswordEdit();

  /// 비밀번호 일치 하는지
  bool isSame = false;

  /// password TextFiled hide
  bool isPwdTextFiledHide = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// TextEditingController 리스너 등록
    passwordEdit.newPassController.addListener(_onChangedPwdTextField);
    passwordEdit.newPass2Controller.addListener(_onChangedPwdTextField);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Frame.myAppbar(title),

      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                _buildGuideBox(),

                /// 현재 비밀번호
                SignTextField(controller: passwordEdit.beforePassController, headText: '현재 비밀번호', hint: '특수,대소문자,숫자포함 7자~15자 입력해주세요.', type: 'pass'),

                SizedBox(height: 25),

                /// 새 비밀번호
                PwdTextFiled(
                    headText: '새 비밀번호',
                    hint: '특수,대소문자,숫자 포함 7자~15자 입력해주세요.',
                    isViewPoint: false,
                    controller: passwordEdit.newPassController,
                    isSame: isSame
                ),

                /// 새 비밀번호 확인
                PwdTextFiled(
                    headText: '새 비밀번호 확인 ',
                    hint: '새 비밀번호 재 입력해주세요.',
                    isViewPoint: isPwdTextFiledHide,
                    controller: passwordEdit.newPass2Controller,
                    isSame: isSame
                ),


                PwdChangeButton(passwordEdit: passwordEdit, context: context, editInfoCompleteMsg: ()=>widget.editInfoCompleteMsg())
              ],
            ),
          ),
        ),
      )
    );
  }

  /// 회원가입 가이드 문구
  _buildGuideBox() {
    return Container(
      height: 50,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 15),
      decoration: BoxDecoration(
        color: guideBackGroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Frame.myText(
            text: PASS_GUIDE_PHRASE_EDIT,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
            fontSize: 0.9,
            maxLinesCount: 2,
            align: TextAlign.center),
      ),
    );
  }

  ///  Listener function of TextEditingController
  void _onChangedPwdTextField() {

    if (passwordEdit.newPassController.text.isNotEmpty && passwordEdit.newPass2Controller.text.isNotEmpty) {
      if (passwordEdit.newPassController.text != passwordEdit.newPass2Controller.text)
      {
        setState(() {
          isPwdTextFiledHide = true;
          isSame = false;
          mLog.d('isPwdTextFiledHide: $isPwdTextFiledHide / isSame: $isSame');
        });
      }
      else {
        setState(() {
          isPwdTextFiledHide = true;
          isSame = true;
          mLog.d('isPwdTextFiledHide: $isPwdTextFiledHide / isSame: $isSame');

        });
      }
    }
  }
}
