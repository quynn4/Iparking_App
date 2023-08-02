
import 'package:dartz/dartz.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/entities/upload_image_dto.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/repositories/scan_qr_repository.dart';
import 'package:ipacking_app/src/shared/error/failures.dart';
import 'package:ipacking_app/src/shared/usecases/usecase.dart';

class UploadCardEventImage implements UseCase<bool, UploadImageDto> {
  final ScanQRRepository _repository;

  UploadCardEventImage(this._repository);

  @override
  Future<Either<Failure, bool>> call(UploadImageDto params) {
    return _repository.uploadCardEventImage(params);
  }
}
