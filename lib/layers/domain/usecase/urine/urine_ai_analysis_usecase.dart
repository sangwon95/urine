


import '../../../../common/di/di.dart';
import '../../repository/urine_repository.dart';
import '../base_usecase.dart';

/// 유린기 Ai 성분분석 유스케이스
class UrineAiAnalysisUseCase implements BaseUseCase<void, Map<String, dynamic>> {
  final UrineRepository _urineRepository;

  UrineAiAnalysisUseCase([UrineRepository? urineRepository])
      : _urineRepository = urineRepository ?? locator();

  @override
  Future<String?> execute(Map<String, dynamic> toMap) {
    return _urineRepository.getAiAnalysis(toMap);
  }
}