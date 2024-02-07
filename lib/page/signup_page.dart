import 'package:flutter/material.dart';

import '../../utils/color.dart';
import '../../utils/edit_controller.dart';
import '../../widgets/button.dart';

import '../main.dart';
import '../utils/frame.dart';
import '../widgets/text_field.dart';

/// 회원가입 화면
class SignUpPage extends StatefulWidget {

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {

  /// Sign TextEditingController
  final SignEdit editSignCnt = SignEdit();

  /// appbar title
  late String title;

  /// 생년월일
  late String dateBirth;

  /// 직무
  late String jobName;

  /// 비밀번호 일치 하는지
  bool isSame = false;

  /// password TextFiled hide
  bool isPwdTextFiledHide = false;


  @override
  void initState() {
    super.initState();

    /// TextEditingController 리스너 등록
    editSignCnt.passController.addListener(_onChangedPwdTextField);
    editSignCnt.pass2Controller.addListener(_onChangedPwdTextField);

    _initStringText();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    editSignCnt.passController.dispose();
    editSignCnt.pass2Controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Frame.myAppbar(title),

      body: GestureDetector(
        onTap: ()
        {
          FocusScope.of(context).unfocus();  // 키보드 내리기
        },
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children:
              [
                /// 회원가입 안내
                _buildGuideBox(),

                /// 회원정보 입력란
                _buildSignItem(),

                /// 회원가입 버튼
                Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.only(bottom: 40),
                    child: SignButton(context: context, signEdit: editSignCnt))
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
      height: 145,
      width: double.infinity,
      decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: FractionalOffset.bottomLeft,
            end: FractionalOffset.topRight,
            colors:
            [
              Color(0xff4182db),
              Color(0xff6fbcd2),
            ],
            stops:
            [
              0.1, 1.0
            ],
          )
      ),
      margin: const EdgeInsets.fromLTRB(30, 10, 30, 15),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5, top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Frame.myText(
                      text: '검사기 간편 회원가입',
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      maxLinesCount: 2,
                      fontSize: 1.6,
                      align: TextAlign.center),
                  SizedBox(height: 5),
                  Frame.myText(
                      text: '회원가입 후 다양한 서비스를 경험해보세요!',
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      maxLinesCount: 2,
                      fontSize: 0.9,
                      align: TextAlign.center),
                ],
              ),
            ),
            Image.asset(
              'images/register_image.png',
              color: registerIconColor,
              height: 87,
            )
          ],
        ),
      ),
    );
  }

 /// 회원가입 Item
  _buildSignItem() {
    return Container(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          /// 아이디
          SignTextField(
              controller: editSignCnt.idController,
              headText: '아이디',
              hint: '아이디를 입력해주세요.',
              type: 'id'
          ),
          SizedBox(height: 5),

          SignTextField(
              controller: editSignCnt.nameController,
              headText: '이름',
              hint: '이름을 입력해주세요.',
              type: 'name'
          ),
          SizedBox(height: 5),

          /// 비밀번호
          PwdTextFiled(
              headText: '비밀번호',
              hint: '특수,대소문자,숫자 7~15자 입력해주세요.',
              isViewPoint: false,
              controller: editSignCnt.passController,
              isSame: isSame
          ),
          SizedBox(height: 5),

          /// 비밀번호 확인
          PwdTextFiled(
              headText: '비밀번호 확인 ',
              hint: '비밀번호를 재 입력해주세요.',
              isViewPoint: isPwdTextFiledHide,
              controller: editSignCnt.pass2Controller,
              isSame: isSame
            ),
        ],
      ),
    );
  }



  /// Initial Text
  _initStringText() {
    title = '회원 가입';
  }


  ///  Listener function of TextEditingController
  _onChangedPwdTextField() {
    mLog.d('_onChangedPwd 실행 : ${editSignCnt.pass2Controller.text}');

    if (editSignCnt.passController.text.isNotEmpty && editSignCnt.pass2Controller.text.isNotEmpty) {
      if (editSignCnt.passController.text != editSignCnt.pass2Controller.text) {
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

