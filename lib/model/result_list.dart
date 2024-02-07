

import 'package:urine/model/rest_response.dart';

class ResultList{
  String datetime;
  String positiveCnt;
  String negativeCnt;

  ResultList({required this.datetime, required this.positiveCnt, required this.negativeCnt});

  factory ResultList.fromJson(Map<String, dynamic> json) {
    return ResultList(
      datetime    : json['datetime'] ?? '-' ,
      positiveCnt : json['positiveCnt'] ?? '-' ,
      negativeCnt : json['negativeCnt'] ?? '-'  ,
    );
  }

  static List<ResultList> parse(RestResponseDataList responseBody) {
    return responseBody.data.map<ResultList>((json) => ResultList.fromJson(json)).toList();
  }

}