import 'package:dartz/dartz.dart';


import '../../../../shared/entitis/auth.dart';
import '../../../../shared/error/failures.dart';
import '../entities/login_dto.dart';

abstract class AuthRepository {
  Future<Either<Failure, Auth>> loginWithEmail(LoginDTO loginDTO);

  Future<Either<Failure, Auth>> logOut();

  Future<Either<Failure, Auth>> checkAuth();
}
