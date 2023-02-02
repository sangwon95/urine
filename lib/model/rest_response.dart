
import '../main.dart';

/// Default Rest Response class
/// only login dio
class RestResponseDefault {
  Map<String, dynamic> status;
  Map<String, dynamic> data;

  RestResponseDefault({required this.status, required this.data});


  /// 비밀번호만 다른 경우  data 가 '' 리턴
  /// 아이디 비밀번호 둘다 다른 경우  'ID가 잘못 입력되었거나, 회원가입되지 않은 ID입니다' 메시지 리턴
  /// 성공시에 정상적인 Map<S,d> 형태로 리턴된다.
  factory RestResponseDefault.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> toMap = {'gender' : '', 'resilienceYN': '', 'burnoutYN':''};
    mLog.d('${json['data']}');
    return RestResponseDefault(
        status: json['status'] as Map<String, dynamic>,
        data: json['data'] == ''|| json['data'] == 'ID가 잘못 입력되었거나, 회원가입되지 않은 ID입니다.'? toMap :
        json['data'] as Map<String, dynamic>
    );
  }
}


/// Rest Response class
/// If the data type is in map format
/// @author parksw
class RestResponseDataMap {
  Map<String, dynamic> status;
  Map<String, dynamic> data;

  RestResponseDataMap({required this.status, required this.data});

  /// Json to Object
  factory RestResponseDataMap.fromJson(Map<String, dynamic> json) {
    return RestResponseDataMap(
        status : json['status'] as Map<String, dynamic>,
        data   : json['data'] as Map<String, dynamic>
    );
  }
}


/// Rest Response class
/// only status json
class RestResponseOnlyStatus {
  Map<String, dynamic> status;

  RestResponseOnlyStatus({required this.status});

  /// Json to Object
  factory RestResponseOnlyStatus.fromJson(Map<String, dynamic> json) {
    return RestResponseOnlyStatus(
        status : json['status'] as Map<String, dynamic>,
    );
  }
}


/// Rest Response class
/// If the data type is in String format
/// @author parksw
class RestResponseDataString {
  Map<String, dynamic> status;
  String data;

  RestResponseDataString({required this.status, required this.data});

  /// Json to Object
  factory RestResponseDataString.fromJson(Map<String, dynamic> json) {
    return RestResponseDataString(
        status : json['status'] as Map<String, dynamic>,
        data   : json['data'] as String
    );
  }
}

/// Rest Response class
/// If the data type is in list format
/// @author parksw
class RestResponseDataList {
  Map<String, dynamic> status;
  List<dynamic> data;

  RestResponseDataList({required this.status, required this.data});

  /// Json to Object
  factory RestResponseDataList.fromJson(Map<String, dynamic> json) {
    return RestResponseDataList(
        status : json['status'] as Map<String, dynamic>,
        data   : json['data'] as List<dynamic>
    );
  }
}




