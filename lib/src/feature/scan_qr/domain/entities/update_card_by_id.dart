import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/entities/packing_vehice_by_card_number.dart';

class UpdateCardByIdDTO extends Equatable {
  final String getId;
  final String? getName;
  final bool? getIsActivate;
  final bool? getIsDelete;
  final String? getEventCode;
  final List<ImageClass>? getImageIn;
  final List<ImageClass>? getImageOut;
  final String? getPlateIn;
  final String? getPlateOut;
  final String? getRegisterPlate;
  final String? getCustomerName;
  final bool? getIsDeleted;
  final String? getCardNo;
  final String? getPaperTicketNumber;
  final String? getDateTimeIn;
  final String? getDateTimeOut;
  final String? getUserIDIn;
  final String? getUserIDOut;
  final String? getLaneIDIn;
  final String? getLaneIDOut;
  final String? getCardGroupID;
  final String? getVehicleGroupID;
  final String? getCustomerGroupID;
  final bool? getIsBlackList;
  final String? getCardNumber;
  final bool? getIsIncludePaperTicket;
  final double? getMoneys;

  const UpdateCardByIdDTO(
      {required this.getId,
      this.getName,
      this.getIsActivate,
      this.getIsDelete,
      this.getEventCode,
      this.getImageIn,
      this.getImageOut,
      this.getPlateIn,
      this.getPlateOut,
      this.getRegisterPlate,
      this.getCustomerName,
      this.getIsDeleted,
      this.getCardNo,
      this.getPaperTicketNumber,
      this.getDateTimeIn,
      this.getDateTimeOut,
      this.getUserIDIn,
      this.getUserIDOut,
      this.getLaneIDIn,
      this.getLaneIDOut,
      this.getCardGroupID,
      this.getVehicleGroupID,
      this.getCustomerGroupID,
      this.getIsBlackList,
      this.getCardNumber,
      this.getIsIncludePaperTicket,
      this.getMoneys});

  String? get id => getId;

  String? get name => getName;

  bool? get isActivate => getIsActivate;

  bool? get isDelete => getIsDelete;

  String? get eventCode => getEventCode;

  List<ImageClass>? get imagesIn => getImageIn;

  List<ImageClass>? get imagesOut => getImageOut;

  String? get plateIn => getPlateIn;

  String? get plateOut => getPlateOut;

  String? get registedPlate => getRegisterPlate;

  String? get customerName => getCustomerName;

  bool? get isDeleted => getIsDeleted;

  String? get cardNo => getCardNo;

  String? get paperTicketNumber => getPaperTicketNumber;

  String? get DatetimeIn => getDateTimeIn;

  String? get DateTimeOut => getDateTimeOut;

  String? get UserIDIn => getUserIDIn;

  String? get UserIDOut => getUserIDOut;

  String? get LaneIDIn => getLaneIDIn;

  String? get LaneIDOut => getLaneIDOut;

  String? get CardGroupID => getCardGroupID;

  String? get VehicleGroupID => getVehicleGroupID;

  String? get CustomerGroupID => getCustomerGroupID;

  bool? get IsBlackList => getIsBlackList;

  String? get CardNumber => getCardNumber;

  bool? get IsIncludePaperTicket => getIsIncludePaperTicket;

  double? get Moneys => getMoneys;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = getId;
    map['name'] = getName;
    map['isActivate'] = getIsActivate;
    map['isDelete'] = getIsDelete;
    map['eventCode'] = getEventCode;
    if (getImageIn != null && getImageIn != []) {
      map['imagesIn'] = getImageIn?.map((e) => e.toJson()).toList();
    }
    if (getImageOut != null && getImageOut != []) {
      map['imagesOut'] = getImageOut?.map((e) => e.toJson()).toList();
    }
    map['plateIn'] = getPlateIn;
    map['plateOut'] = getPlateOut;
    map['registedPlate'] = getRegisterPlate;
    map['customerName'] = getCustomerName;
    map['isDeleted'] = getIsDeleted;
    map['cardNo'] = getCardNo;
    map['paperTicketNumber'] = getPaperTicketNumber;
    map['DatetimeIn'] = getDateTimeIn;
    map['DateTimeOut'] = getDateTimeOut;
    map['UserIDIn'] = getUserIDIn;
    map['UserIDOut'] = getUserIDOut;
    map['LaneIDIn'] = getLaneIDIn;
    map['LaneIDOut'] = getLaneIDOut;
    map['CardGroupID'] = getCardGroupID;
    map['VehicleGroupID'] = getVehicleGroupID;
    map['CustomerGroupID'] = getCustomerGroupID;
    map['IsBlackList'] = getIsBlackList;
    map['CardNumber'] = getCardNumber;
    map['IsIncludePaperTicket'] = getIsIncludePaperTicket;
    map['Moneys'] = getMoneys;
    return map;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        getId,
        getName,
        getIsActivate,
        getIsDelete,
        getEventCode,
        getImageIn,
        getImageOut,
        getPlateIn,
        getPlateOut,
        getRegisterPlate,
        getCustomerName,
        getIsDeleted,
        getCardNo,
        getPaperTicketNumber,
        getDateTimeIn,
        getDateTimeOut,
        getUserIDIn,
        getUserIDOut,
        getLaneIDIn,
        getLaneIDOut,
        getCardGroupID,
        getVehicleGroupID,
        getCustomerGroupID,
        getIsBlackList,
        getCardNumber,
        getIsIncludePaperTicket,
        getMoneys,
      ];
}
