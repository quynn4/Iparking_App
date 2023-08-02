import 'package:dartz/dartz.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/entities/card_event.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/entities/update_card_by_id.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/repositories/scan_qr_repository.dart';
import 'package:ipacking_app/src/shared/error/failures.dart';
import 'package:ipacking_app/src/shared/usecases/usecase.dart';

class UpdateCardById implements UseCase<CardEvent, UpdateCardByIdDTO> {
  final ScanQRRepository _repository;

  UpdateCardById(this._repository);

  @override
  Future<Either<Failure, CardEvent>> call(UpdateCardByIdDTO params) {
    return _repository.updateCardById(params);
  }
}
