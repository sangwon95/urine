
import 'package:urine/layers/entity/status_dto.dart';

class SignupDTO {
  StatusDTO status;

  SignupDTO({required this.status});

  /// Json to Object
  factory SignupDTO.fromJson(Map<String, dynamic> json) {
    return SignupDTO(
      status : StatusDTO.fromJson(json['status']),
    );
  }
}