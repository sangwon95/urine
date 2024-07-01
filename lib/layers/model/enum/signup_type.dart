import 'package:urine/common/common.dart';

enum SignupType {
  id('아이디*', Texts.enterIdMsg),
  pass('비밀번호*', Texts.passhintMsg),
  pass2('비밀번호 확인*', Texts.passhintMsg),
  nickname('닉네임*', Texts.enterNickNameMsg),
  birthdate('생년월일', '생년월일을 입력해주세요.'),
  gender('성별', '선택');

  const SignupType(this.title, this.hint);

  final String title;
  final String hint;
}