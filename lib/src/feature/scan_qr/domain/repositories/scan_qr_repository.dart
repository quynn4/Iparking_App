import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/entities/card_event.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/entities/complete_info_by_card_number.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/entities/packing_vehice_by_card_number.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/entities/payment_transaction_dto.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/entities/update_card_by_id.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/entities/upload_image_dto.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/usecases/create_card_by_id_dto.dart';
import 'package:ipacking_app/src/shared/error/failures.dart';

abstract class ScanQRRepository {
  Future<Either<Failure, CompleteInfoByCardNumber>> getCompleteInfoByCardNumber(
      String cardNumber);

  Future<Either<Failure, PackingVehiceByCardNumber>>
      getPackingVehiceByCardNumber(String cardNumber);

  Future<Either<Failure, CardEvent>> updateCardById(
      UpdateCardByIdDTO updateCardByIdDTO);
  Future<Either<Failure, CardEvent>> createCardById(
      CreateCardByIdDTO createCardByIdDTO);
  Future<Either<Failure, bool>> paymentTransaction(
      PaymentTransactionDto paymentTransactionDto);
  Future<Either<Failure, bool>> uploadCardEventImage(
      UploadImageDto uploadImageDto);
}
