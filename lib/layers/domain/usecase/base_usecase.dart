/// T: Result 타입(또는 return type 의미인 'R' 사용)
/// Params: 파라미터 타입

abstract class BaseUseCase<T, Params> {
  Future<T> execute(Params params);
}

abstract class NoParamUseCase<T, Params> {
  Future<T> execute();
}
