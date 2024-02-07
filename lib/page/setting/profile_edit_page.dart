//
//
// import 'package:flutter/material.dart';
// import 'package:urine/utils/frame.dart';
//
// import '../../utils/color.dart';
//
// class ProfileEditPage extends StatefulWidget {
//   const ProfileEditPage({Key? key}) : super(key: key);
//
//   @override
//   State<ProfileEditPage> createState() => _ProfileEditPageState();
// }
//
// class _ProfileEditPageState extends State<ProfileEditPage> {
//   final title = '프로필 수정';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: Frame.myAppbar(
//         title,
//       ),
//       body: FutureBuilder(
//         builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//           if (snapshot.hasError) {
//             return Container(
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(snapshot.error.toString().replaceAll('Exception:', ''),
//                           textScaleFactor: 1.0, style: TextStyle(color: Colors.black)),
//                     ],
//                   ),
//                 ));
//           }
//
//           if (!snapshot.hasData) {
//             return Container(
//                 child: Center(
//                     child: SizedBox(height: 40.0, width: 40.0,
//                         child: CircularProgressIndicator(strokeWidth: 5))));
//           }
//
//           if (snapshot.connectionState == ConnectionState.done) {
//           }
//
//           return Container(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children:
//               [
//                 _buildGuideBox(),
//
//                 /// 현재 비밀번호
//                 SignTextField(controller: passwordEdit.beforePassController, headText: '현재 비밀번호', hint: '특수,대소문자,숫자포함 7자~15자 입력해주세요.', type: 'pass'),
//
//                 SizedBox(height: 25),
//
//                 /// 새 비밀번호
//                 PwdTextFiled(
//                     headText: '새 비밀번호',
//                     hint: '특수,대소문자,숫자 포함 7자~15자 입력해주세요.',
//                     isViewPoint: false,
//                     controller: passwordEdit.newPassController,
//                     isSame: isSame
//                 ),
//
//                 /// 새 비밀번호 확인
//                 PwdTextFiled(
//                     headText: '새 비밀번호 확인 ',
//                     hint: '새 비밀번호 재 입력해주세요.',
//                     isViewPoint: isPwdTextFiledHide,
//                     controller: passwordEdit.newPass2Controller,
//                     isSame: isSame
//                 ),
//
//
//                 PwdChangeButton(passwordEdit: passwordEdit, context: context, editInfoCompleteMsg: ()=>widget.editInfoCompleteMsg())
//               ],
//             ),
//           )
//         },
//
//       ),
//     );
//   }
//
//
//   /// 회원가입 가이드 문구
//   _buildGuideBox() {
//     return Container(
//       height: 50,
//       margin: const EdgeInsets.fromLTRB(20, 0, 20, 15),
//       decoration: BoxDecoration(
//         color: guideBackGroundColor,
//         borderRadius: BorderRadius.circular(5),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Frame.myText(
//             text: '현재 사용하고 계시는 이름만 수정이 가능합니다.',
//             color: Colors.grey.shade700,
//             fontWeight: FontWeight.w500,
//             fontSize: 0.9,
//             maxLinesCount: 2,
//             align: TextAlign.center),
//       ),
//     );
//   }
// }
