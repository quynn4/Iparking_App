import 'package:dartz/dartz.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/entities/payment_transaction_dto.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/repositories/scan_qr_repository.dart';
import 'package:ipacking_app/src/shared/error/failures.dart';
import 'package:ipacking_app/src/shared/usecases/usecase.dart';

class PaymentTransactionUsecase
    implements UseCase<bool, PaymentTransactionDto> {
  final ScanQRRepository _repository;

  PaymentTransactionUsecase(this._repository);

  @override
  Future<Either<Failure, bool>> call(PaymentTransactionDto params) {
    return _repository.paymentTransaction(params);
  }
}
