import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/entities/card_event.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/entities/packing_vehice_by_card_number.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/entities/payment_transaction_dto.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/entities/update_card_by_id.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/entities/upload_image_dto.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/usecases/create_card_by_id.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/usecases/create_card_by_id_dto.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/usecases/get_complete_info_by_card_number.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/usecases/payment_transaction_usecase.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/usecases/update_card_by_id.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/usecases/upload_card_event_image.dart';
import 'package:ipacking_app/src/shared/services/plate_recognize_response.dart';

import '../../../../shared/blocs_app/loading_cubit/loading_cubit.dart';
import '../../../../shared/services/dio_upload_service.dart';
import '../../domain/entities/complete_info_by_card_number.dart';
import '../../domain/usecases/get_packing_vehice_by_card_number.dart';

part 'scan_qr_event.dart';

part 'scan_qr_state.dart';

class ScanQRBloc extends Bloc<ScanQREvent, ScanQRState> {
  final LoadingCubit loadingCubit;
  final GetCompleteInfoByCardNumber getCompleteInfo;
  final GetPackingVehiceByCardNumber getPackingVehiceInfo;
  final UpdateCardById updateCardById;
  final CreateCardById createCardById;
  final PaymentTransactionUsecase paymentTransactionUsecase;
  final UploadCardEventImage uploadCardEventImage;
  final DioUploadService dioUploadService;

  ScanQRBloc(
      this.loadingCubit,
      this.getCompleteInfo,
      this.getPackingVehiceInfo,
      this.dioUploadService,
      this.updateCardById,
      this.createCardById,
      this.uploadCardEventImage,
      this.paymentTransactionUsecase)
      : super(ScanQRStateInitial()) {
    on<CompleteInfoSubmitted>(_onCompleteInfoSubmitted);
    on<PackingVehiceSubmitted>(_onPackingVehiceSubmitted);
    on<ScanQRStatusChanged>(_onScanQRStatusChanged);
    on<ValidatePlateSubmitted>(_onValidatePlateSubmitted);
    on<UpdateCardByIdSubmitted>(_onUpdateCardByIdSubmitted);
    on<CreateCardByIdSubmitted>(_onCreateCardByIdSubmitted);
    on<UploadImageSubmitted>(_onUploadImageSubmitted);
    on<PaymentTransactionSubmitted>(_onPaymentTransactionSubmitted);
  }

  void _onScanQRStatusChanged(
    ScanQRStatusChanged event,
    Emitter<ScanQRState> emit,
  ) {
    emit(ScanQRStateInitial());
  }

  void _onPackingVehiceSubmitted(
    PackingVehiceSubmitted event,
    Emitter<ScanQRState> emit,
  ) async {
    loadingCubit.showLoading();
    await getPackingVehiceInfo(event.cardNumber).then((result) {
      loadingCubit.hideLoading();
      result.fold((l) {
        emit(GetPackingVehiceInfoFailure(l.message));
      }, (r) {
        emit(GetPackingVehiceInfoState(r));
      });
    });
  }

  void _onCompleteInfoSubmitted(
    CompleteInfoSubmitted event,
    Emitter<ScanQRState> emit,
  ) async {
    loadingCubit.showLoading();
    await getCompleteInfo(event.cardNumber).then((result) {
      loadingCubit.hideLoading();
      result.fold((l) {
        emit(GetCompleteInfoFailure(l.message));
      }, (r) {
        emit(GetCompleteInfoState(r));
      });
    });
  }

  void _onValidatePlateSubmitted(
      ValidatePlateSubmitted event, Emitter<ScanQRState> emit) async {
    loadingCubit.showLoading();
    await dioUploadService.uploadPhotos(event.image).then((value) {
      loadingCubit.hideLoading();
      Map<String, dynamic> map = jsonDecode(value);
      PlateRecognizeResponse plate = PlateRecognizeResponse.fromJson(map);
      emit(ValidatePlateState(plate));
    });
  }

  void _onUpdateCardByIdSubmitted(
      UpdateCardByIdSubmitted event, Emitter<ScanQRState> emit) async {
    loadingCubit.showLoading();
    await updateCardById(event.updateCardByIdDTO).then((value) {
      loadingCubit.hideLoading();
      value.fold((l) {
        emit(UpdateCardByIdFailure(l.message));
      }, (r) {
        emit(UpdateCardByIdState(r));
      });
    });
  }

  void _onPaymentTransactionSubmitted(
      PaymentTransactionSubmitted event, Emitter<ScanQRState> emit) async {
    loadingCubit.showLoading();
    await paymentTransactionUsecase(event.paymentTransactionDto).then((value) {
      loadingCubit.hideLoading();
      value.fold((l) {
        emit(PaymentTransactionFailure(l.message));
      }, (r) {
        emit(PaymentTransactionState());
      });
    });
  }

  void _onCreateCardByIdSubmitted(
      CreateCardByIdSubmitted event, Emitter<ScanQRState> emit) async {
    loadingCubit.showLoading();
    await createCardById(event.createCardByIdDTO).then((value) {
      loadingCubit.hideLoading();
      value.fold((l) {
        emit(UpdateCardByIdFailure(l.message));
      }, (r) {
        emit(CreateCardByIdState(r));
      });
    });
  }

  void _onUploadImageSubmitted(
      UploadImageSubmitted event, Emitter<ScanQRState> emit) {
    emit(UploadImageState());
  }
}
