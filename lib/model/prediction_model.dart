
import 'package:urine/model/rest_response.dart';

class PredictionModel{
  String dataType;
  String name;
  String info;
  String symptoms;
  String disease;
  String food;
  String exercise;

  PredictionModel({
    required this.dataType,
    required this.name,
    required this.info,
    required this.symptoms,
    required this.disease,
    required this.food,
    required this.exercise
    });

  factory PredictionModel.fromJson(RestResponseDataMap responseBody) {
    return PredictionModel(
        dataType : responseBody.data['dataType'] ?? '-',
        name     : responseBody.data['name'] ?? '-',
        info     : responseBody.data['info'] ?? '-',
        symptoms : responseBody.data['symptoms'] ?? '-',
        disease  : responseBody.data['disease'] ?? '-',
        food     : responseBody.data['food'] ?? '-',
        exercise : responseBody.data['exercise'] ?? '-'
    );
  }

  @override
  String toString() {
    return 'PredictionModel{dataType: $dataType, name: $name, info: $info, symptoms: $symptoms, disease: $disease, food: $food, exercise: $exercise}';
  }
}