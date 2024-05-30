import 'package:get_it/get_it.dart';
import 'package:urine/layers/data/%20repository/urine/urine_repository_imp.dart';
import 'package:urine/layers/domain/repository/urine_repository.dart';

import '../../layers/data/ repository/auth_repository_imp.dart';
import '../../layers/domain/repository/auth_repository.dart';

/// getIt, inject, locator
final locator = GetIt.instance;

initLocator() {
  locator.registerLazySingleton<AuthRepository>(() => AuthRepositoryImp());
  locator.registerLazySingleton<UrineRepository>(() => UrineRepositoryImp());
}
