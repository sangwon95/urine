
import 'package:urine/model/rest_response.dart';

class StatusModel{
  String code;
  String? message;

  StatusModel({required this.code, required this.message});

  factory StatusModel.fromJson(RestResponseOnlyStatus statusBody){
    return StatusModel(
      code    : statusBody.status['code'],
      message : statusBody.status['message'],
    );
  }
}