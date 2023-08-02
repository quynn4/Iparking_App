import 'package:dartz/dartz.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/entities/complete_info_by_card_number.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/repositories/scan_qr_repository.dart';
import 'package:ipacking_app/src/shared/usecases/usecase.dart';

import '../../../../shared/error/failures.dart';

class GetCompleteInfoByCardNumber implements UseCase<CompleteInfoByCardNumber, String> {
  final ScanQRRepository _repository;

  GetCompleteInfoByCardNumber(this._repository);

  @override
  Future<Either<Failure, CompleteInfoByCardNumber>> call(String params) {
    return _repository.getCompleteInfoByCardNumber(params);
  }
}