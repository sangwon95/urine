import '../../../../common/di/di.dart';
import '../../../entity/urine_chart_dto.dart';
import '../../repository/urine_repository.dart';
import '../base_usecase.dart';

/// 검사 결과 추이 차트 유스케이스
class UrineChartCase implements BaseUseCase<void, Map<String, dynamic>> {
  final UrineRepository _urineRepository;

  UrineChartCase([UrineRepository? urineRepository]) : _urineRepository = urineRepository ?? locator();

  @override
  Future<UrineChartDTO?> execute(Map<String, dynamic> searchDateMap) {
    return _urineRepository.fetchUrineChart(searchDateMap);
  }
}