
/// 권한 계정 클래스
class Authorization{
  late String userID;
  late String password;
  late String address;
  late String name;
  late String type;


  /// 한번 초기화로 계속 사용할 수 있다.
  static final Authorization _authInstance = Authorization.internal();

  factory Authorization(){
    return _authInstance;
  }

  Authorization.internal() {
     userID   = '';
     password = '';
     address = '';
     name = '';
     type = '';
  }

  clear(){
     userID   = '';
     password = '';
     address = '';
     name = '';
     type = '';
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> toMap = {
      'userID'   : userID,
      'password' : password,
    };
    return toMap;
  }


}