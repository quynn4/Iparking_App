import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ipacking_app/src/feature/scan_qr/data/datasources/scan_qr_remote_data_source.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/entities/card_event.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/entities/complete_info_by_card_number.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/entities/packing_vehice_by_card_number.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/entities/payment_transaction_dto.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/entities/update_card_by_id.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/entities/upload_image_dto.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/usecases/create_card_by_id_dto.dart';
import 'package:ipacking_app/src/shared/error/failures.dart';

import '../../domain/repositories/scan_qr_repository.dart';

class ScanQRRepositoryImpl extends ScanQRRepository {
  final ScanQRRemoteDataSource _remoteDataSource;

  ScanQRRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, CompleteInfoByCardNumber>> getCompleteInfoByCardNumber(
      String cardNumber) async {
    return await _remoteDataSource.completeInfoByCardNumber(cardNumber);
  }

  @override
  Future<Either<Failure, PackingVehiceByCardNumber>>
      getPackingVehiceByCardNumber(String cardNumber) async {
    return await _remoteDataSource.packingVehiceByCardNumber(cardNumber);
  }

  @override
  Future<Either<Failure, CardEvent>> updateCardById(
      UpdateCardByIdDTO updateCardByIdDTO) async {
    return await _remoteDataSource.updateCardById(updateCardByIdDTO);
  }
  @override
  Future<Either<Failure, CardEvent>> createCardById(
      CreateCardByIdDTO createCardByIdDTO) async {
    return await _remoteDataSource.createCardByID(createCardByIdDTO);
  }
  @override
  Future<Either<Failure, bool>> paymentTransaction(
      PaymentTransactionDto paymentTransactionDto) async {
    return await _remoteDataSource.paymentTransaction(paymentTransactionDto);
  }
  @override
  Future<Either<Failure, bool>> uploadCardEventImage(
      UploadImageDto uploadImageDto) async {
    return await _remoteDataSource.uploadCardEventImage(uploadImageDto);
  }
}
