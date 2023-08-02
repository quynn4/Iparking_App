import 'package:dartz/dartz.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/entities/card_event.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/usecases/create_card_by_id_dto.dart';

import '../../../../shared/error/failures.dart';
import '../../../../shared/usecases/usecase.dart';
import '../repositories/scan_qr_repository.dart';

class CreateCardById implements UseCase<CardEvent, CreateCardByIdDTO> {
  final ScanQRRepository _repository;

  CreateCardById(this._repository);

  @override
  Future<Either<Failure, CardEvent>> call(CreateCardByIdDTO params) {
    return _repository.createCardById(params);
  }
}
