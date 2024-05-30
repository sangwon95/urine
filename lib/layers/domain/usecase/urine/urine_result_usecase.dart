

import 'package:urine/layers/entity/urine_result_dto.dart';

import '../../../../common/di/di.dart';
import '../../repository/urine_repository.dart';
import '../base_usecase.dart';

/// 유린기 결과 리스트 조회 유스케이스
class UrineResultCase implements BaseUseCase<void, String> {
  final UrineRepository _urineRepository;

  UrineResultCase([UrineRepository? urineRepository]) : _urineRepository = urineRepository ?? locator();

  @override
  Future<UrineResultDTO?> execute(String dateTime) {
    return _urineRepository.getUrineResult(dateTime);
  }
}