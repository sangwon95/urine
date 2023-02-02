import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences{
  //set
  void setStringData(String key , String data) async{
    var pref = await SharedPreferences.getInstance();
    pref.setString(key,data);
  }


  void setIntData(String key , int data) async{
    var pref = await SharedPreferences.getInstance();
    pref.setInt(key,data);
  }


  void setDoubleData(String key , double data) async{
    var pref = await SharedPreferences.getInstance();
    pref.setDouble(key,data);
  }


  void setBoolData(String key , bool data) async{
    var pref = await SharedPreferences.getInstance();
    pref.setBool(key,data);
  }


  void setListData(String key , List<String> data) async{
    var pref = await SharedPreferences.getInstance();
    pref.setStringList(key,data);
  }


   Future<String?> getStringData(String key) async{
    var pref = await SharedPreferences.getInstance();
    return  pref.getString(key);
  }
  /// userID :  ID 저장
  /// password : 패스 워드 저장

  Future<int?> getIntData(String key) async{
    var pref = await SharedPreferences.getInstance();
    return pref.getInt(key);
  }


  Future<double?> getDoubleData(String key) async{
    var pref = await SharedPreferences.getInstance();
    return pref.getDouble(key);
  }


  Future<bool?> getBoolData(String key) async{
    var pref = await SharedPreferences.getInstance();
    return pref.getBool(key);
  }


  Future<List<String>?> getListData(String key) async{
    var pref = await SharedPreferences.getInstance();
    return pref.getStringList(key);
  }


  //delete
  void remove(String key) async{
    var prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}