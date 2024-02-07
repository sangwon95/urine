
const String APP_NAME = 'Health Care';
const String APP_VERSION = '1.0.0';


const String BASE_URL           = '106.251.70.71:50010';
const String API_PREFIX         = 'http://$BASE_URL/ws';

const String API_URL_LOGIN      = '$API_PREFIX/public/user/login';      // 로그인
const String API_USER_INSERT    = '$API_PREFIX/public/user/insert';     // 회원가입
const String API_RESULT_RECENT  = '$API_PREFIX/urine/result/recent';    // 최근 검사 내역
const String API_RESULT         = '$API_PREFIX/urine/result';           // 특정 날짜 결과 내역
const String API_RESULT_LIST    = '$API_PREFIX/urine/result/list';      // 검사 리스트
const String API_CHART_DATA     = '$API_PREFIX/urine/result/data/list'; // 차트 데이터
const String API_PERDICTION     = '$API_PREFIX/urine/prediction';       // 건강 예찰
const String API_GET_INFO       = '$API_PREFIX/private/user/get';       // 회원 정보 가져오기
const String API_URINE_INSERT   = '$API_PREFIX/urine/result/insert';    // 최근 결과 데이터 저장

/// 한밭대학교 AI분석 API
const String API_AI = 'https://optosta-new.wisoft.io/new-predict';


// MESSAGE_
const String MESSAGE_LOGIN_FALSE          = '로그인 실패';
const String MESSAGE_CHECK_ID_PASS        = '아이디 또는 비밀번호를 확인하세요.';
const String MESSAGE_NOT_EXIST_RESULT     = '요청한 파라미터의 결과 데이터가 존재하지 않습니다.';
const String MESSAGE_ERROR_CONNECT_SERVER = '서버 연결 오류입니다. 재시도 바랍니다.';
const String MESSAGE_AVAILABLE_ID         = '사용 가능한 ID입니다.';
const String MESSAGE_INSERT_FAILURE       = '입력되지 못했습니다. 다시 시도바랍니다.';
const String MESSAGE_UPDATE_FAILURE       = '회원 정보 변경이 실패 했습니다. 다시 시도바랍니다.';
const String MESSAGE_DB_DUPLICATE_ERROR   = 'DB 키중복 오류가 발생했습니다.';


// ERROR
const String MESSAGE_ERROR_RESPONSE = '현재 서버를 찾을 수 없습니다. 다시 시도바랍니다.';
const String MESSAGE_ERROR_CONNECT  = '서버와 연결이 불안하여 응답을 받지 못했습니다.';
const String MESSAGE_ERROR_RECEIVE  = '서버가 불안정 하여 응답을 받지 못합니다.';
const String MESSAGE_ERROR_UNKNOWN  = '알 수 없는 서버 오류 입니다. 다시 시도바랍니다.';
const String MESSAGE_NO_RESULT_DATA = '해당 날짜 데이터 기록이 없습니다.';
const String MESSAGE_SERVER_ERROR_DEFAULT = '서버 오류 발생 재시도 바랍니다.';

// CODE
const String SUCCESS      = '200';
const String DB_DUPLICATE = 'ERR_EVS_8013'; // DB 중복 코드
const String LOGIN_ERROR  = 'ERR_LOGIN'; // DB 중복 코드
const String UNKNOWN_ERROR = '-1';


const String MSG_SIGN_SUCCESS = '회원가입이 완료 되었습니다.';
const String SING_GUIDE_PHRASE = '반갑습니다. HealthCare 회원가입 안내입니다. 아래의 정보를 정확히 입력해 주시기 바랍니다.';
const String SING_GUIDE_PHRASE_EDIT = '정확한 연구분석과 맞춤형 심리 케어 솔루션 제공을 위해 아래의 정보를 정확하게 입력 및 수정 바랍니다.';
const String PASS_GUIDE_PHRASE_EDIT = '비밀번호 변경 후 로그인 화면으로 이동되며, 변경 된 비밀번호로 로그인 바랍니다.';
const String RESILIENCE_GUIDE_PHRASE = '지난 일주일 동안 아래의 문항을 어느 정도 경험했는지 질문에 응답해주세요.';
const String RESILIENCE_GUIDE_PHRASE2 = '지난 며칠 동안 어느 정도 변화가 있었는지 경험했는지 질문에 응답해주세요.';
const String TERMS_GUIDE_PHRASE = '휴스테이션이 처음이시군요.\n약관내용에 동의해주세요.';
const String LOGIN_TEXT = '스트레스에 지친 직장인을 위한\n마음 회복관리 심리챗봇';

const String RESILIENCE_END_MESSAGE = '수고하셨습니다. 위 선택한 내용 다시 확인 후 버튼 눌러주세요.';
const String CHATBOT_NOT_SERVICE = '상담 전문가 소개 메뉴로 이동';
const String CHATBOT_END_MESSAGE = '상담 메뉴 선택 화면으로 이동';

const String FIND_ID_DESCRIPTION   = '$APP_NAME에 가입했던 이름, 이메일을 입력해주세요.\n아이디를 메일로 보내드립니다.';
const String FIND_PASS_DESCRIPTION  = '$APP_NAME에 가입했던 아이디,이름,이메일을 입력해주세요.\n임시 비밀번호를 메일로 보내드립니다.';
const String FIND_COMPLETE_MAIL_MSG = '메일이 전송되었습니다. 확인바랍니다.';

// GATT UUID
const String BLE_GATT_UUID_GATT_SERVICE = '0783b03e-8535-b5a0-7140-a304d2495cb7';
const String BLE_GATT_UUID_NOTIFICATION = '0783b03e-8535-b5a0-7140-a304d2495cb8';
const String BLE_GATT_UUID_WRITE        = '0783b03e-8535-b5a0-7140-a304d2495cba';

// const String NEW_BLE_GATT_UUID_GATT_SERVICE = '6e400001-b5a3-f393-e0a9-e50e24dcca9e';
// const String NEW_BLE_GATT_UUID_NOTIFICATION = '6e400003-b5a3-f393-e0a9-e50e24dcca9e';
// const String NEW_BLE_GATT_UUID_WRITE        = '6e400002-b5a3-f393-e0a9-e50e24dcca9e';

const jobNameList  = [
 ' 보건의료직',
 ' 제조생산직',
 ' 고객응대직',
 ' 심리상담직',
 ' 기타'
];

// 검사 항목 리스트
const inspectionItemList  = [
 '잠혈',
 '빌리루빈',
 '우로빌리노겐',
 '케톤체',
 '단백질',
 '아질산염',
 '포도당',
 '산성도',
 '비중',
 '백혈구',
 '비타민',
];

const inspectionItemTypeList = [
 'DT01',
 'DT02',
 'DT03',
 'DT04',
 'DT05',
 'DT06',
 'DT07',
 'DT08',
 'DT09',
 'DT10',
 'DT11',
];

// speech bubble 위치
// abstract class MessagePosition {
//  static const left  = 'left';
//  static const right = 'right';
// }

enum InspectionType {
 basic,
 ai
}

abstract class InspectionStatus {
 static const first  = '1';
 static const second = '2';
}


abstract class ResilienceStep {
 static const first  = '1';
 static const second = '2';
}

abstract class ChatFileCode {
 static const burnout = 'in';
 static const main = 'fi';
 static const resilience = 're';
 static const satisfaction = 'sa';
 static const endGuide = 'en';
}

// 검사 항목 리스트
const AIResult = [
 [
  '만성 신장 질환은 신장의 기능이 점차적으로 손상되는 질환으로, 초기에는 특별한 증상이 나타나지 않을 수 있지만, 질환의 진행에 따라 다양한 증상이 나타날 수 있습니다. 일반적으로 다음과 같은 증상이 나타날 수 있습니다.\n',

  '• 소변의 양이 감소하거나 빈도가 증가하는 경우\n'+
      '• 더 자주 복통이나 허리 통증이 발생하는 경우\n'+
      '• 두통, 혼동, 혈압상승, 호흡곤란, 발목이 부음 등의 증상이 나타나는 경우\n'+
      '• 손발이 저리거나 근육 경련 등의 증상이 나타나는 경우\n',

  '만성 신장 질환은 신장의 기능이 점차적으로 손상되는 질환으로, 다양한 원인에 의해 발생할 수 있습니다. 주요한 원인으로는 다음과 같은 질병들이 있습니다.\n',

  '• 당뇨병: 고혈당으로 인해 신장의 혈관과 신장 조직이 손상되는 경우에 발생할 수 있습니다.\n• 고혈압: 고혈압이 지속되면 신장의 혈관이 손상되어 신장 기능이 저하될 수 있습니다.\n• 만성 신염: 장기적으로 발생하는 신염으로, 신장 조직에 손상을 일으켜 신장 기능이 저하될 수 있습니다.\n• 다른 질환에 의한 합병증: 대사성 질환, 면역성 질환, 갑상선 기능저하증, 난치성 질환 등 다양한 질병들이 신장 기능 저하를 유발할 수 있습니다.\n\n',

  '만성 신장 질환을 가진 환자의 식이 요법은 신장 기능을 유지하고 건강한 신장을 유지하기 위한 중요한 역할을 합니다. 일반적으로 다음과 같은 권장 사항이 있습니다\n',

  '• 단백질 섭취량 조절: 신장이 손상된 환자는 과다한 단백질 섭취가 신장에 부담을 줄 수 있으므로, 식이에서 섭취하는 단백질의 양을 제한해야 합니다. 일반적으로 하루에 0.6g ~ 0.8g의 단백질을 섭취하는 것이 권장됩니다.\n'+
      '• 칼륨 조절: 신장 기능이 저하된 환자는 칼륨 수치가 높아지는 것을 방지하기 위해 식이에서 칼륨 섭취량을 제한해야 합니다. 칼륨 제한이 필요한 경우, 과일, 채소, 난류 등 칼륨이 많이 포함된 식품을 섭취하지 않도록 주의해야 합니다.',

  '만성 신장 질환을 가진 환자의 경우, 신장 기능이 손상될 수 있는 높은 인텐시티나 고강도의 운동은 피해야 합니다. 그러나 일부 운동은 신장 기능을 개선하고 건강한 신장을 유지하는 데 도움이 될 수 있습니다. 다음은 만성 신장 질환 환자에게 권장되는 운동 가이드입니다\n',

  '• 유산소 운동: 걷기, 자전거 타기, 수영 등 중강도의 유산소 운동은 신장 기능을 개선하고 혈압을 낮추는 데 효과적입니다. 하지만 인텐시티가 너무 높아지면 근육 대사 과정에서 생성되는 폐기물을 신장이 처리하는 것이 부담이 될 수 있으므로, 적절한 인텐시티와 시간으로 운동을 실시하는 것이 중요합니다.\n'+
      '• 요가, 타이 치, 기타 안정적인 운동: 요가, 타이 치, 필라테스 등 안정적이고 저강도의 운동은 근력, 유연성, 균형, 호흡, 자세 등을 개선하는 데 효과적입니다. 그러나 운동 시에 너무 긴장하거나 힘을 빼지 않도록 주의해야 합니다.\n\n'
 ],

 [
  '방광염은 방광 내막이 염증을 일으키는 질환으로, 다양한 원인에 의해 발생할 수 있습니다. 주요 증상은 다음과 같습니다.\n',

  '• 자주 소변을 볼 때\n'+
      '• 급작스럽게 소변을 볼 필요성을 느낄 때\n'+
      '• 소변을 보는 데에 통증이나 따끔거림을 느낄 때\n'+
      '• 발열이 동반될 때\n'+
      '• 이러한 증상이 나타나면 즉시 전문의를 방문하여 치료를 받는 것이 좋습니다.\n',

  '방광염은 방광 내막이 염증을 일으키는 질환으로, 다양한 원인에 의해 발생합니다.\n주로 박테리아나 바이러스에 의한 감염, 알레르기 반응, 자극적인 화학물질에 노출, 방광의 근육 기능 이상 등이 원인이 될 수 있습니다.\n',

  '방광염이 생긴 경우, 미생물이나 알레르기 반응에 의한 경우 등에 따라 다른 질병으로 진행될 가능성도 있습니다.\n예를 들어, 만성 방광염은 장기적인 염증으로 인해 방광 기능에 영향을 미치는데, 이 경우에는 방광암, 방광결석 등의 합병증이 발생할 가능성이 있습니다.\n 따라서, 증상이 나타난 경우 전문의를 방문하여 정확한 진단과 치료가 필요합니다.\n\n',

      '방광염의 식이요법은 기본적으로 자극적인 음식과 음료를 피하는 것이 중요합니다.\n 특히 다음과 같은 식품을 제한하는 것이 좋습니다.\n\n'+
      '• 커피, 차, 탄산음료 등 자극적인 음료 알코올,\n• 담배 등의 유해물질 매운 음식,\n• 청량고추, 간장, 소금 등 자극적인 조미료\n\n',

  '반면 다음과 같은 식품을 적극적으로 섭취하는 것이 좋습니다.\n'+
      '• 물, 천연 주스, 녹차 등의 무자극적인 음료\n'+
      '• 식초, 오이, 김치 등의 식품\n',

  '방광염 증상이 심한 경우에는 휴식이 필요할 수 있지만,경증 증상의 경우에는 일부 운동을 시도해 볼 수 있습니다.\n방광염 치료를 위해 권장되는 일부 운동에는 다음과 같은 것이 있습니다.\n',

  '• 적당한 유산소 운동: 유산소 운동은 신진대사를 촉진하고 체내 독소를 제거하는 데 도움이 됩니다.\n적당한 운동으로는 걷기, 조깅, 자전거 타기, 수영 등이 있습니다.\n하지만, 과도한 운동은 증상을 악화시킬 수 있으므로, 적당한 운동량을 유지하는 것이 중요합니다.\n'+
  '• 신장 건강을 돕는 운동: 방광염은 대개 신장과 관련된 질환이므로, 신장 건강을 돕는 운동도 추천됩니다.\n신장 건강을 돕는 운동으로는 근력 운동, 요가, 태극권 등이 있습니다.\n'
 ],

 [
  '췌장염(pancreatitis)은 췌장이 염증을 일으키는 질환으로, 다음과 같은 증상이 나타날 수 있습니다.\n',

  '• 상복부 통증: 상복부에서 시작되어 등 또는 아래배로 퍼질 수 있는 지속적인 심한 통증을 경험할 수 있습니다.\n'+
      '• 구토: 구토, 소화불량, 메스꺼움 등의 소화기 증상을 경험할 수 있습니다.\n'+
      '• 체중 감소: 식욕부진, 체중 감소 등의 증상이 나타날 수 있습니다.\n\n'+
      '- 췌장염은 만성 췌장염과 급성 췌장염으로 나뉘며, 급성 췌장염은 위와 같은 증상이 급격하게 나타나는 경우가 많습니다. 만성 췌장염은 반복적인 급성 췌장염의 경향이 있으며, 복부 통증과 소화기 증상 등이 지속될 수 있습니다. 만약 위와 같은 증상이 나타나면 즉시 의료진과 상담하여 치료를 받아야 합니다.\n\n',

  '췌장염은 췌장의 염증으로 인해 발생하는 질환으로, 다음과 같은 요인이 췌장염의 원인이 될 수 있습니다.\n',

  '• 알코올 소비: 지나친 알코올 소비는 췌장염을 일으킬 수 있습니다.\n'+
  '• 과도한 지방 섭취: 과도한 지방 섭취는 췌장의 기능을 저하시켜 췌장염을 유발할 수 있습니다.\n'+
  '• 유전적 요인: 유전적인 요인도 췌장염의 원인이 될 수 있습니다.\n\n',

      '췌장염 환자의 식이 요법은 췌장의 염증을 완화시키고 췌장의 기능을 유지하기 위해 중요합니다. 췌장염 환자는 다음과 같은 식이 요법을 지켜야 합니다.\n',

      '• 저지방 식단: 지방 함량이 낮은 식품을 섭취해야 합니다. 특히, 포화 지방산이 많은 음식은 피해야 합니다. 식용유, 버터, 크림, 치즈, 고기 등은 가능한 한 자제해야 합니다.\n'+
      '• 액체 섭취: 많은 양의 물과 각종 액체를 섭취하여 몸 내부의 수분을 충분히 채워주는 것이 중요합니다. 하지만, 카페인이나 알코올은 가급적 피해야 합니다.\n'+
      '• 특별한 식품: 특별한 효과를 가진 식품으로는, 녹차, 생강, 큐컴버, 토마토, 블루베리 등이 있습니다.\n',

  '췌장염 환자는 적극적인 운동을 권장하지 않습니다. 췌장의 염증으로 인해 복부 통증이나 불쾌감이 발생할 수 있으며, 심한 경우에는 운동으로 인해 췌장에 더 많은 부담이 가해질 수 있습니다.\n하지만, 일부 환자들은 적절한 운동을 통해 건강을 유지할 수 있습니다. 이 경우, 다음과 같은 사항을 유의해야 합니다.\n',

  '• 의사와 상의: 반드시 의사와 상의한 후 운동을 시작해야 합니다. 의사는 췌장염 환자의 신체 상태와 운동 가능성을 평가할 수 있습니다.\n\n'+
      '• 저강도 운동: 저강도 운동으로 걷기, 요가, 태극권 등의 운동을 추천합니다. 강도가 낮은 운동을 통해 체력 유지와 근육 강화를 할 수 있습니다.\n\n'+
      '• 수분 섭취: 운동 중에는 충분한 수분을 섭취해야 합니다. 하지만, 과도한 음주는 가급적 피해야 합니다.\n\n'+
      '• 운동 시간 조절: 아침이나 밤, 기온이 낮은 시간에 운동하는 것이 좋습니다. 특히, 열대 지방에서는 더위 때문에 운동 중 열사병 등의 위험을 감수해야 하므로 조심해야 합니다.\n\n'
 ],

 [
  '빈혈의 증상은 빈혈의 원인, 정도, 지속 기간 등에 따라 다양하게 나타날 수 있습니다. 일반적으로 빈혈의 주요 증상은 다음과 같습니다.\n',

  '• 피로감: 쉬지 않아도 지치고 피곤한 느낌이 드는 것으로, 일상생활에서의 활동이나 운동이 힘들어집니다.\n'+
      '• 식욕 부진: 식욕이 떨어져서 식사량이 감소합니다.\n'+
      '• 빈맥 등의 피부 변화: 혈액순환에 문제가 생길 경우, 피부에 빈맥 등의 변화가 생길 수 있습니다.\n'+
      '• 심장 박동 수 증가: 빈혈일 때, 심장은 산소를 더 많이 공급하기 위해 더 빠르게 박동을 하게 됩니다.\n\n',

  '다양한 원인에 의해 빈혈이 발생할 수 있습니다. 일반적으로 빈혈의 원인과 관련된 질병은 다음과 같습니다.\n',

  '• 철분결핍성 빈혈: 철분 섭취 부족이나 흡수 장애, 출혈 등에 의해 철분 부족 상태가 지속되면서 발생하는 빈혈입니다.\n'+
      '• 비타민 B12 결핍성 빈혈: 위산 부족, 장 질환 등의 원인으로 비타민 B12의 흡수가 잘 이루어지지 않아 발생하는 빈혈입니다.\n'+
      '• 유전성 빈혈: 유전적으로 적혈구 생성이 불량하거나 소멸이 많아지는 질환으로, 대표적으로 유전성 간질성 빈혈이 있습니다.\n\n',

  '빈혈 식이 요법의 핵심은 적혈구 생성에 필요한 철분, 비타민 B12, 엽산 등을 충분히 섭취하는 것입니다. 다음은 빈혈 식이 요법의 간단한 가이드라인입니다.\n',

  '• 철분 섭취: 적극적인 철분 섭취가 필요합니다. 빈혈 환자는 철분 함량이 높은 채소인 시금치, 브로콜리, 콩 등을 섭취하거나, 건강한 체중 유지를 위한 닭고기, 붉은 고기 등을 섭취해야 합니다.\n'+
      '• 비타민 B12 섭취: 비타민 B12 결핍성 빈혈 환자는 육류, 생선, 새우, 우유 등을 충분히 섭취해야 합니다. 비건이나 채식주의자의 경우에는 비타민 B12 보충제를 별도로 섭취해야 합니다.\n'+
      '• 식이섬유 섭취: 식이섬유가 많은 과일과 채소를 충분히 섭취하여, 소화기 건강을 유지하는 것이 좋습니다.\n',

  '빈혈 환자의 경우, 체력을 과도하게 소모하지 않는 범위 내에서 꾸준한 유산소 운동을 추천합니다. 운동을 할 때는 다음과 같은 가이드라인을 따르는 것이 좋습니다.\n',

  '• 적당한 강도의 운동: 과도한 신체 활동은 체력을 고갈시켜 빈혈 증상을 악화시킬 수 있으므로, 적당한 강도의 유산소 운동을 꾸준히 하는 것이 좋습니다.\n'+
      '• 유산소 운동: 유산소 운동은 산소 공급을 증가시키고, 혈액순환을 원활하게 해주어 빈혈 환자에게 적합합니다. 보통 걷기, 뛰기, 수영, 자전거 타기 등의 운동이 유산소 운동에 해당합니다.\n'+
      '• 의사와 상의: 빈혈 환자의 경우 신체 상태에 따라 운동이 불가능한 경우도 있으므로, 의사와 상의하여 적절한 운동 계획을 수립하는 것이 중요합니다.\n\n'
 ],

 [
  '당뇨병의 예상 증상은 다음과 같습니다.\n',

  '• 자주 소변을 보게 된다.\n'+
      '• 목마름을 느끼게 된다.\n'+
      '• 식욕이 불안정해지거나 급격히 증가하는 경우가 있다.\n'+
      '• 상처가 잘 나거나, 상처가 난 부위가 느리게 나았다.\n',

  '당뇨병은 자신의 혈당 수치가 계속해서 높아지면서 발생하는 만성질환입니다. 다음과 같은 질병들이 당뇨병의 합병증으로 발생할 수 있습니다.\n',

  '• 심혈관계 질환: 고혈압, 심근경색, 뇌졸중 등이 포함됩니다.\n'+
      '• 신장 질환: 신부전, 신경병증 등이 있습니다.\n'+
      '• 시력 손상: 망막병증 등이 있습니다.\n'+
      '• 발병증: 궤양, 골절 등이 있습니다.\n',

  '당뇨병에 걸린 사람들은 식사를 할 때 식이요법을 따라야 합니다. 일반적으로 당뇨병 환자들은 고칼로리, 고지방, 고탄수화물 식품을 피해야 합니다. 이는 혈당 수치를 유지하고 관리하기 위해서입니다.\n',

  '• 식사 간격 조절: 식사 간격을 일정하게 조절하고, 과식을 피합니다.\n'+
      '• 탄수화물 섭취량 조절: 탄수화물 섭취량을 조절하며, 고탄수화물 식품을 피하고, 식사 중에는 과일이나 채소를 충분히 섭취합니다.\n'+
      '• 식사 내용 다양화: 식사 내용을 다양화하고, 당도가 높은 음료나 과자, 간식은 피합니다.\n',

  '당뇨병 환자도 꾸준한 운동 생활을 통해 건강을 유지할 수 있습니다. 당뇨병 환자가 권장하는 운동은 심혈관 운동과 저항성 운동입니다.\n',

  '• 심혈관 운동: 심혈관 운동은 대표적으로 걷기, 조깅, 수영, 자전거 타기 등이 있습니다. 이러한 운동은 심박수를 높여 혈액순환을 원활하게 하며, 혈당 조절 효과가 크기 때문에 당뇨병 환자들이 많이 선택합니다. 운동 강도와 시간을 조절하여 맞추는 것이 중요합니다.\n'

 ],

 [
  '신장염의 예상 증상은 다음과 같을 수 있습니다.\n',

      '• 흔한 증상: 피로감, 체중 감소, 소화 불량, 식욕부진, 복통, 근육 경련 등이 있을 수 있습니다.\n'+
      '• 배뇨 관련 증상: 소변의 양이 증가하거나 감소할 수 있으며, 자주 배뇨하거나 밤에 잦은 방뇨가 발생할 수 있습니다.\n'+
      '• 상처가 잘 나거나, 상처가 난 부위가 느리게 나았다.\n',

  '이러한 증상이 나타날 경우 의료진과 상담하여 적절한 진단과 치료를 받아야 합니다. \n',

  '• 신장염이 예상되는 몇 가지 주요 질병들은 다음과 같습니다.\n'+
      '•신장염이 만성화되면 신장 기능이 점차 저하되고, 신부전으로 진행될 수 있습니다.\n'+
      '•신장 손상으로 인해 신경계에 영향을 주어 신경병증이 발생할 수 있습니다.\n'+
      '•신장은 혈압을 조절하는 역할을 합니다. 신장 손상으로 인해 혈압 조절이 어려워지면 고혈압이 발생할 수 있습니다.\n',

  '다음은 신장염 환자를 위한 간단한 식이요법 지침입니다\n',

  '• 고단백 식품은 신장에 부담을 줄 수 있으므로 제한해야 합니다.\n'+
      '• 신장염 환자는 나트륨 섭취를 제한해야 합니다. 가공식품, 소금이 많이 포함된 음식, 높은 나트륨 함유량을 가진 조미료 및 소스를 피해야 합니다.\n'+
      '• 수분 섭취: 수분은 신장 기능을 돕는데 중요합니다. 충분한 물을 마시고, 체내 수분을 유지하세요.\n',

  '다음은 신장염 환자를 위한 간단한 운동 가이드입니다\n',

  '•유산소 운동은 심혈관 건강을 증진시키고 체중을 관리하는 데 도움을 줍니다. 걷기, 조깅, 수영, 자전거 타기와 같은 저강도 유산소 운동을 선택하세요. 운동 강도와 시간을 조절하여 개인의 체력에 맞추세요.\n'
 ],

 [
  '건강검진 요망합니다.','','건강검진 요망합니다.','','건강검진 요망합니다.','','건강검진 요망합니다.','',
 ]



 ];

enum MessagePosition { left, right }
enum ChatBotType { consult , burnout,end }
// abstract class ChatBotStatus {
//  static const chatBot = 'ch';   // 상담 메뉴 챗봇
//  static const burnout = 'burn'; // 초기 번아웃 스크리닝
//  static const end = 'end';      // 마무리 후 번아웃 스크리닝
// }





