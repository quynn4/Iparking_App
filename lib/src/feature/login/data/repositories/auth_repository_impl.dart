import 'package:dartz/dartz.dart';

import '../../../../shared/entitis/auth.dart';
import '../../../../shared/error/failures.dart';
import '../../domain/entities/login_dto.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';


class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Either<Failure, Auth>> loginWithEmail(LoginDTO loginDTO) async {
    final authInfo = await _remoteDataSource.loginWithEmail(loginDTO);
    return authInfo.fold((l) => Left(l), (authInfo) => _localDataSource.cacheAuth(authInfo));
  }
  @override
  Future<Either<Failure, Auth>> logOut() async {
    return _localDataSource.clearAuth();
  }
  @override
  Future<Either<Failure, Auth>> checkAuth() {
    return _localDataSource.getAuth();
  }
}
