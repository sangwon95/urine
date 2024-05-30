import 'package:urine/layers/entity/urine_save_dto.dart';

import '../../../../common/di/di.dart';
import '../../repository/urine_repository.dart';
import '../base_usecase.dart';

/// 유린기 결과 데이터 저장 유스케이스
class UrineSavaUesCase implements BaseUseCase<void, List<Map<String, dynamic>>> {
  final UrineRepository _urineRepository;

  UrineSavaUesCase([UrineRepository? urineRepository]) : _urineRepository = urineRepository ?? locator();

  @override
  Future<UrineSaveDTO?> execute(List<Map<String, dynamic>> toMap) {
    return _urineRepository.saveUrine(toMap);
  }
}