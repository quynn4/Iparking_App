part of 'scan_qr_bloc.dart';

abstract class ScanQRState extends Equatable {}

class ScanQRStateInitial extends ScanQRState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class GetCompleteInfoState extends ScanQRState {
  final CompleteInfoByCardNumber completeInfoByCardNumber;

  GetCompleteInfoState(this.completeInfoByCardNumber);

  @override
  List<Object?> get props => [completeInfoByCardNumber];
}

class GetCompleteInfoFailure extends ScanQRState {
  final String message;

  GetCompleteInfoFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class GetPackingVehiceInfoFailure extends ScanQRState {
  final String message;

  GetPackingVehiceInfoFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class GetPackingVehiceInfoState extends ScanQRState {
  final PackingVehiceByCardNumber packingVehiceByCardNumber;

  GetPackingVehiceInfoState(this.packingVehiceByCardNumber);

  @override
  List<Object?> get props => [packingVehiceByCardNumber];
}

class ValidatePlateState extends ScanQRState {
  final PlateRecognizeResponse plateRecognizeResponse;

  ValidatePlateState(this.plateRecognizeResponse);

  @override
  List<Object?> get props => [plateRecognizeResponse];
}

class UpdateCardByIdFailure extends ScanQRState {
  final String message;

  UpdateCardByIdFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdateCardByIdState extends ScanQRState {
  UpdateCardByIdState(this.cardEvent);

  final CardEvent cardEvent;

  @override
  List<Object?> get props => [cardEvent];
}

class CreateCardByIdState extends ScanQRState {
  CreateCardByIdState(this.cardEvent);

  final CardEvent cardEvent;

  @override
  List<Object?> get props => [cardEvent];
}

class PaymentTransactionState extends ScanQRState {
  PaymentTransactionState();

  @override
  List<Object?> get props => [];
}
class PaymentTransactionFailure extends ScanQRState {
  final String message;

  PaymentTransactionFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class UploadImageState extends ScanQRState {
  UploadImageState();

  @override
  List<Object?> get props => [];
}
