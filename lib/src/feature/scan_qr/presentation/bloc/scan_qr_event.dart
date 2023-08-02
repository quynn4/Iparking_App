part of 'scan_qr_bloc.dart';

abstract class ScanQREvent extends Equatable {
  const ScanQREvent();

  @override
  List<Object> get props => [];
}

class CompleteInfoSubmitted extends ScanQREvent {
  final String cardNumber;

  const CompleteInfoSubmitted(this.cardNumber);

  @override
  List<Object> get props => [cardNumber];
}

class PackingVehiceSubmitted extends ScanQREvent {
  final String cardNumber;

  const PackingVehiceSubmitted(this.cardNumber);

  @override
  List<Object> get props => [cardNumber];
}

class ValidatePlateSubmitted extends ScanQREvent {
  final String image;

  const ValidatePlateSubmitted(this.image);

  @override
  List<Object> get props => [image];
}

class ScanQRStatusChanged extends ScanQREvent {
  const ScanQRStatusChanged();
}

class UpdateCardByIdSubmitted extends ScanQREvent {
  final UpdateCardByIdDTO updateCardByIdDTO;

  const UpdateCardByIdSubmitted(this.updateCardByIdDTO);

  @override
  List<Object> get props => [updateCardByIdDTO];
}

class CreateCardByIdSubmitted extends ScanQREvent {
  final CreateCardByIdDTO createCardByIdDTO;

  const CreateCardByIdSubmitted(this.createCardByIdDTO);

  @override
  List<Object> get props => [createCardByIdDTO];
}

class PaymentTransactionSubmitted extends ScanQREvent {
  final PaymentTransactionDto paymentTransactionDto;

  const PaymentTransactionSubmitted(this.paymentTransactionDto);

  @override
  List<Object> get props => [paymentTransactionDto];
}

class UploadImageSubmitted extends ScanQREvent {
  const UploadImageSubmitted();
}
