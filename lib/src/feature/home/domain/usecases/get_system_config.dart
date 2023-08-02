import 'package:dartz/dartz.dart';
import 'package:ipacking_app/src/feature/home/domain/entities/system_config.dart';
import 'package:ipacking_app/src/feature/home/domain/repositories/home_repository.dart';
import 'package:ipacking_app/src/shared/error/failures.dart';
import 'package:ipacking_app/src/shared/usecases/usecase.dart';

class GetSystemConfigUseCase implements UseCase<SystemConfig, bool> {
  final HomeRepository _repository;

  GetSystemConfigUseCase(this._repository);

  @override
  Future<Either<Failure, SystemConfig>> call(bool params) {
    return _repository.getSystemConfig();
  }
}
