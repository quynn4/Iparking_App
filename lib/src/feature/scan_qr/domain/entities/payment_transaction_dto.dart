import 'package:equatable/equatable.dart';

class PaymentTransactionDto extends Equatable {
  final String getId;
  final String? getParkingEventId;
  final int? getPaymentMethod;
  final int? getType;
  final String? getDateCreate;
  final String? getUser;
  final PayInformationDto? getPayInformation;
  final List<String>? getLinkedTransaction;
  final String? getVoucher;
  final bool? getIsDelete;

  const PaymentTransactionDto({
    required this.getId,
    this.getParkingEventId,
    this.getPaymentMethod,
    this.getType,
    this.getDateCreate,
    this.getUser,
    this.getPayInformation,
    this.getLinkedTransaction,
    this.getVoucher,
    this.getIsDelete,
  });

  String? get id => getId;

  String? get parkingEventId => getParkingEventId;

  int? get paymentMethod => getPaymentMethod;

  int? get type => getType;

  String? get dateCreate => getDateCreate;

  String? get user => getUser;

  PayInformationDto? get payInformation => getPayInformation;

  List<String>? get linkedTransaction => getLinkedTransaction;

  String? get voucher => getVoucher;

  bool? get isDelete => getIsDelete;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Id'] = getId;
    map['ParkingEventId'] = getParkingEventId;
    map['PaymentMethod'] = getPaymentMethod;
    map['Type'] = getType;
    map['DateCreated'] = getDateCreate;
    map['User'] = getUser;
    if (getPayInformation != null) {
      map['payInformation'] = getPayInformation!.toJson();
    }
    map['LinkedTransaction'] = getLinkedTransaction;
    map['Voucher'] = getVoucher;
    map['IsDelete'] = getIsDelete;
    return map;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        getId,
        getParkingEventId,
        getPaymentMethod,
        getPaymentMethod,
        getType,
        getDateCreate,
        getUser,
        getPayInformation,
        getLinkedTransaction,
        getVoucher,
        getIsDelete,
      ];
}

class PayInformationDto {
  final int getFee;
  final int getDiscount;
  final int getPaid;

  PayInformationDto({
    required this.getFee,
    required this.getDiscount,
    required this.getPaid,
  });

  int? get fee => getFee;

  int? get discount => getDiscount;

  int? get paid => getPaid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Fee'] = getFee;
    map['Discount'] = getDiscount;
    map['Paid'] = getPaid;
    return map;
  }
}
