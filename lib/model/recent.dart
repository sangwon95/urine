
import 'package:urine/model/rest_response.dart';

class Recent{
  String datetime;
  String dataType;
  String result;
  String status;

  Recent({required this.datetime, required this.dataType, required this.result, required this.status});


  factory Recent.fromJson(Map<String, dynamic> json) {
    return Recent(
      datetime : json['datetime'] ?? '-' ,
      dataType : json['dataType'] ?? '-' ,
      result   : json['result'] ?? '-'  ,
      status   : json['status'] ?? '-' ,
    );
  }

  static List<Recent> parse(RestResponseDataList responseBody) {
    return responseBody.data.map<Recent>((json) => Recent.fromJson(json)).toList();
  }
}