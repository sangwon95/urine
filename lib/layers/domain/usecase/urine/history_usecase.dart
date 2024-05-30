
import '../../../../common/di/di.dart';
import '../../../entity/history_dto.dart';
import '../../../model/vo_history.dart';
import '../../repository/urine_repository.dart';
import '../base_usecase.dart';

/// 유린기 히스토리 유스케이스
class HistoryCase implements BaseUseCase<void, History> {
  final UrineRepository _urineRepository;

  HistoryCase([UrineRepository? urineRepository]) : _urineRepository = urineRepository ?? locator();

  @override
  Future<HistoryDTO?> execute(History params) {
    return _urineRepository.getHistory(params);
  }
}