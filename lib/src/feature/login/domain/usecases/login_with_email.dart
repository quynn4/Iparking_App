import 'package:dartz/dartz.dart';

import '../../../../shared/entitis/auth.dart';
import '../../../../shared/error/failures.dart';
import '../../../../shared/usecases/usecase.dart';
import '../entities/login_dto.dart';
import '../repositories/auth_repository.dart';


class LoginWithEmail implements UseCase<Auth, LoginDTO> {
  final AuthRepository _repository;

  LoginWithEmail(this._repository);

  @override
  Future<Either<Failure, Auth>> call(LoginDTO params) {
    return _repository.loginWithEmail(params);
  }
}