

class Texts {
  static const  appName = 'Yocheck';
  static const appVersion = '1.1.7';
  static const androidBuildVersion = '11';
  static const iosBuildVersion = '11';
  static const currentYear = '2024';

  static const imagePath = 'assets/images';

  static const passwordRegExp = '^(?=.*[0-9])(?=.*[a-z])(?=.*\\W).{7,15}';



  /// [화면][상태][목적] 형식으로 네이밍
  // login
  static const loginLabel = '로그인';
  static const loginEmptyField = '아이디와 비밀번호를 입력해주세요.';
  static const loginFailed = '아이디, 비밀번호가 일치하지 않습니다.';

  // signup
  static const signupLabel = '회원가입';
  static const signupSuccess = '회원가입이 완료되었습니다.';
  static const duplicateIdMsg = '중복된 아이디입니다.\n다시 입력해주세요.';
  static const signupFailed = '회원가입이 정상적으로 처리되지 않았습니다.';
  static const enterIdMsg = '아이디를 입력해주세요.';
  static const idMinLengthMsg = '아이디를 6자 이상 입력해주세요.';
  static const enterPassMsg = '비밀번호를 입력해주세요.';
  static const passValidationMsg = '특수,소문자,숫자 포함 7~15자로\n입력해주세요.';
  static const passhintMsg = '특수,소문자,숫자 포함 7~15자';
  static const reenterPassMsg = '비밀번호를 재입력해주세요.';
  static const passMismatchMsg = '비밀번호가 일치하지 않습니다.';
  static const currentPassMismatchMsg = '현재 비밀번호가 일치하지 않습니다.';
  static const enterNickNameMsg = '닉네임 입력해주세요.';
  static const nicknameShortMsg = '닉네임이 너무 짧습니다.';
  static const nicknameMinLengthMsg = '닉네임 7자 이내로 작성해주세요.';


  static const allTermsAgreementMsg = '이용약관 모두 동의해주세요.';


  static const PASSWORD_CHANGE_SUCCESS = '비밀번호가 변경되었습니다.';
  static const PASSWORD_CHANGE_FAILURE = '비밀번호 변경이 정상적으로\n처리되지 않았습니다.';
  static const UNEXPECTED_ERROR = '죄송합니다.\n예기치 않은 문제가 발생했습니다.';

  // network
  static const successCode = '200';
  static const duplicationCode = 'ERR_EVS_8013'; // 중복코드
  static const unexpectedError = '죄송합니다.\n예기치 않은 문제가 발생했습니다.';
  static const connectionError = '네트워크 연결 상태를\n확인 해주세요.';
  static const badCertificate = '서버 상태가 불안정합니다.\n다시 시도바랍니다.';
  static const unknownError = '서버 점검중입니다.\n잠시후 시도해주세요.';


}