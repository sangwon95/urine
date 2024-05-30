enum SignupType {
  id('아이디*', '아이디를 입력해주세요.'),
  pass('비밀번호*', '특수,소문자,숫자 포함 7~15자'),
  pass2('비밀번호 확인*', '특수,소문자,숫자 포함 7~15자'),
  nickname('닉네임*', '닉네임 입력해주세요.'),
  birthdate('생년월일', '생년월일을 입력해주세요.'),
  gender('성별', '선택');

  const SignupType(this.title, this.hint);

  final String title;
  final String hint;
}