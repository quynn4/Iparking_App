import 'package:dartz/dartz.dart';
import 'package:ipacking_app/src/feature/home/data/datasources/home_remote_data_source.dart';
import 'package:ipacking_app/src/feature/home/domain/entities/lane_class.dart';
import 'package:ipacking_app/src/feature/home/domain/entities/system_config.dart';
import 'package:ipacking_app/src/feature/home/domain/repositories/home_repository.dart';
import 'package:ipacking_app/src/shared/error/failures.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDataSource _remoteDataSource;

  HomeRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, SystemConfig>> getSystemConfig() async {
    return await _remoteDataSource.getSystemConfig();
  }
  @override
  Future<Either<Failure, List<LaneClass>>> getLane() async {
    return await _remoteDataSource.getLane();
  }
}
