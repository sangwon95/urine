

const String baseUrl = 'http://221.168.252.145:51001/ws';

/// 테스트 서버
//const String urineBaseUrl = 'http://192.168.0.54:50010/ws'; // 내부 테스트 서버
//const String urineBaseUrl = 'http://106.251.70.71:50010/ws';// 외부 서버


/// 로그인
const String loginApiUrl = '$baseUrl/public/user/login';

/// 회원가입 URL
const String signupApiUrl = '$baseUrl/public/user/insert';

/// 로그아웃 URL
const String logoutApiUrl = '$baseUrl/private/user/logout';

/// 검사 히스토리 조회 URL
const String historyListApiUrl = '$baseUrl/urine/result/list';

/// 검사 결과 조회 URL
const String urineResultApiUrl = '$baseUrl/urine/result';

/// 검사 결과 추이 차트 조회 URL
const String chartApiUrl = '$baseUrl/urine/result/data/list';

/// AI 성분 분석을 위한 최근 검사 데이터 조회 URL
const String recentResultApiUrl = '$baseUrl/urine/result/recent';

/// 한밭대학교 Ai 성분 분석 API URL
const String aiAnalysisApiUrl = 'https://optosta-new.wisoft.io/new-predict';

/// 소변 검사 결과 데이터 저장
const String saveResultApiUrl = '$baseUrl/urine/result/insert';

/// 유저 이름 가져오기
const String getUserNameApiUrl = '$baseUrl/private/user/get';

/// 비밀번호 변경
const String changePassApiUrl ='$baseUrl/private/user/password/update';