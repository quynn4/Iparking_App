import 'package:dio/dio.dart';

class PackingVehiceByCardNumber {
  final String id;
  final String eventCode;
  final String cardNumber;
  final String datetimeIn;
  final String dateTimeOut;
  final List<ImageClass> imagesIn;
  final List<ImageClass> imagesOut;
  final String laneIDIn;
  final String laneIDOut;
  final String userIDIn;
  final String userIDOut;
  final String plateIn;
  final String plateOut;
  final String registedPlate;
  final double moneys;
  final String cardGroupID;
  final String vehicleGroupID;
  final String customerGroupID;
  final String customerName;
  final bool isBlackList;
  final bool isFree;
  final bool isDelete;
  final String freeType;
  final String cardNo;
  final String description;
  final String paperTicketNumber;
  final bool isIncludePaperTicket;
  final String unsignPlateIn;
  final String unsignPlateOut;
  final int feePaid;
  final int discount;
  final String vouchers;
  final List<String> paymentTransactions;
  final String token;
  final String inUserName;
  final String inLaneName;
  final String outUserName;
  final String outLaneName;
  final String customerGroupName;
  final String cardGroupName;
  final String vehicleGroupName;

  PackingVehiceByCardNumber(
      {required this.id,
      required this.eventCode,
      required this.cardNumber,
      required this.datetimeIn,
      required this.dateTimeOut,
      required this.imagesIn,
      required this.imagesOut,
      required this.laneIDIn,
      required this.laneIDOut,
      required this.userIDIn,
      required this.userIDOut,
      required this.plateIn,
      required this.plateOut,
      required this.registedPlate,
      required this.moneys,
      required this.cardGroupID,
      required this.vehicleGroupID,
      required this.customerGroupID,
      required this.customerName,
      required this.isBlackList,
      required this.isFree,
      required this.isDelete,
      required this.freeType,
      required this.cardNo,
      required this.description,
      required this.paperTicketNumber,
      required this.isIncludePaperTicket,
      required this.unsignPlateIn,
      required this.unsignPlateOut,
      required this.feePaid,
      required this.discount,
      required this.vouchers,
      required this.paymentTransactions,
      required this.token,
      required this.inUserName,
      required this.inLaneName,
      required this.outUserName,
      required this.outLaneName,
      required this.customerGroupName,
      required this.cardGroupName,
      required this.vehicleGroupName});
}

class ImageClass {
  final String filePath;
  final int displayIndex;
  final String description;

  ImageClass(
      {required this.filePath,
      required this.displayIndex,
      required this.description});

  String? get FilePath => filePath;

  int get DisplayIndex => displayIndex;

  String get Description => description;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["FilePath"] = filePath;
    data["DisplayIndex"] = displayIndex;
    data["Description"] = description;
    return data;
  }
}
