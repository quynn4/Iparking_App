import 'package:dartz/dartz.dart';
import 'package:ipacking_app/src/feature/home/domain/entities/lane_class.dart';
import 'package:ipacking_app/src/feature/home/domain/entities/system_config.dart';
import 'package:ipacking_app/src/shared/error/failures.dart';

abstract class HomeRepository {
  Future<Either<Failure, SystemConfig>> getSystemConfig();
  Future<Either<Failure, List<LaneClass>>> getLane();
}