
class StatusDTO {
  final String code;
  final String message;

  StatusDTO({
    required this.code,
    required this.message,
  });

  factory StatusDTO.fromJson(Map<String, dynamic> json){
    return StatusDTO(
        code: json['code'],
        message: json['message']
    );
  }
}
