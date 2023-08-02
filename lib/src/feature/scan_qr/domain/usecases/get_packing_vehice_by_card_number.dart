import 'package:dartz/dartz.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/entities/packing_vehice_by_card_number.dart';

import '../../../../shared/error/failures.dart';
import '../../../../shared/usecases/usecase.dart';
import '../repositories/scan_qr_repository.dart';

class GetPackingVehiceByCardNumber
    implements UseCase<PackingVehiceByCardNumber, String> {
  final ScanQRRepository _repository;

  GetPackingVehiceByCardNumber(this._repository);

  @override
  Future<Either<Failure, PackingVehiceByCardNumber>> call(String params) {
    return _repository.getPackingVehiceByCardNumber(params);
  }
}
