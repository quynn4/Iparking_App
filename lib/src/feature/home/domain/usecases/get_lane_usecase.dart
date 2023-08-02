import 'package:dartz/dartz.dart';
import 'package:ipacking_app/src/feature/home/domain/entities/lane_class.dart';
import 'package:ipacking_app/src/shared/usecases/usecase.dart';

import '../../../../shared/error/failures.dart';
import '../repositories/home_repository.dart';

class GetLaneUseCase implements UseCase<List<LaneClass>, bool> {
  final HomeRepository _repository;

  GetLaneUseCase(this._repository);

  @override
  Future<Either<Failure, List<LaneClass>>> call(bool params) {
    return _repository.getLane();
  }
}