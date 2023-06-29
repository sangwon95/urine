
import 'package:shared_preferences/shared_preferences.dart';

/// 권한 계정 클래스
class Authorization{
  late String userID;
  late String password;
  late String name;
  late String type;
  late String token;

  /// 한번 초기화로 계속 사용할 수 있다.
  static final Authorization _authInstance = Authorization.internal();

  factory Authorization(){
    return _authInstance;
  }

  Authorization.internal() {
     userID   = '';
     password = '';
     name = '';
     type = '';
     token = '';
  }

  clear() async {
    var pref = await SharedPreferences.getInstance();
    pref.clear();
     userID   = '';
     password = '';
     name = '';
     type = '';
     token = '';
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> toMap = {
      'userID'   : userID,
      'password' : password,
    };
    return toMap;
  }


}