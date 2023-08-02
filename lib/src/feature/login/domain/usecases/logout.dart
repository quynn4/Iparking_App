import 'package:dartz/dartz.dart';

import '../../../../shared/entitis/auth.dart';
import '../../../../shared/error/failures.dart';
import '../../../../shared/usecases/usecase.dart';
import '../repositories/auth_repository.dart';


class LogOut implements UseCase<Auth, NoParams> {
  final AuthRepository _repository;

  LogOut(this._repository);

  @override
  Future<Either<Failure, Auth>> call(NoParams params) {
    return _repository.logOut();
  }
}