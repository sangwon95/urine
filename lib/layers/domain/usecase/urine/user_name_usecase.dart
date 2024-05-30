import 'package:urine/layers/entity/urine_save_dto.dart';
import 'package:urine/layers/entity/user_name_dto.dart';

import '../../../../common/di/di.dart';
import '../../repository/urine_repository.dart';
import '../base_usecase.dart';

/// 유린기 결과 데이터 저장 유스케이스
class UserNameUesCase implements NoParamUseCase<void, void> {
  final UrineRepository _urineRepository;

  UserNameUesCase([UrineRepository? urineRepository]) : _urineRepository = urineRepository ?? locator();

  @override
  Future<UserNameDTO?> execute() {
    return _urineRepository.getUserName();
  }
}