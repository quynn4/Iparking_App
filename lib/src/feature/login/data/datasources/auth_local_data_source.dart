import 'package:dartz/dartz.dart';

import '../../../../shared/entitis/auth.dart';
import '../../../../shared/error/failures.dart';
import '../../../../shared/services/local_store_service.dart';


class AuthLocalDataSource {
  final LocalStorageService _storageService;

  AuthLocalDataSource(this._storageService);

  Future<Either<Failure, Auth>> cacheAuth(Auth authInfo) {
    return _storageService.cacheAuthInfo(token: authInfo.token);
  }

  Future<Either<Failure, Auth>> getAuth() {
    return _storageService.getAuthInfo();
  }

  Future<Either<Failure, Auth>> clearAuth() async {
    await _storageService.clearUrlInfo();
    return _storageService.clearAuthInfo();
  }
}
