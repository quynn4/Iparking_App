import 'package:dartz/dartz.dart';

import '../../../../shared/entitis/auth.dart';
import '../../../../shared/error/failures.dart';
import '../../../../shared/usecases/usecase.dart';
import '../repositories/auth_repository.dart';


class CheckAuth implements UseCase<Auth, NoParams> {
  final AuthRepository _repository;

  CheckAuth(this._repository);

  @override
  Future<Either<Failure, Auth>> call(NoParams params) async {
    return _repository.checkAuth();
  }
}