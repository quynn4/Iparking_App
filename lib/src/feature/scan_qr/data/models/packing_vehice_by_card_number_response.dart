class PackingVehiceByCardNumberResponse {
  String? id;
  String? eventCode;
  String? cardNumber;
  String? datetimeIn;
  String? dateTimeOut;
  List<ImageResponse>? imagesIn;
  List<ImageResponse>? imagesOut;
  String? laneIDIn;
  String? laneIDOut;
  String? userIDIn;
  String? userIDOut;
  String? plateIn;
  String? plateOut;
  String? registedPlate;
  double? moneys;
  String? cardGroupID;
  String? vehicleGroupID;
  String? customerGroupID;
  String? customerName;
  bool? isBlackList;
  bool? isFree;
  bool? isDelete;
  String? freeType;
  String? cardNo;
  String? description;
  String? paperTicketNumber;
  bool? isIncludePaperTicket;
  String? unsignPlateIn;
  String? unsignPlateOut;
  int? feePaid;
  int? discount;
  String? vouchers;
  List<String>? paymentTransactions;
  String? token;
  String? inUserName;
  String? inLaneName;
  String? outUserName;
  String? outLaneName;
  String? customerGroupName;
  String? cardGroupName;
  String? vehicleGroupName;

  PackingVehiceByCardNumberResponse(
      {this.id,
      this.eventCode,
      this.cardNumber,
      this.datetimeIn,
      this.dateTimeOut,
      this.imagesIn,
      this.imagesOut,
      this.laneIDIn,
      this.laneIDOut,
      this.userIDIn,
      this.userIDOut,
      this.plateIn,
      this.plateOut,
      this.registedPlate,
      this.moneys,
      this.cardGroupID,
      this.vehicleGroupID,
      this.customerGroupID,
      this.customerName,
      this.isBlackList,
      this.isFree,
      this.isDelete,
      this.freeType,
      this.cardNo,
      this.description,
      this.paperTicketNumber,
      this.isIncludePaperTicket,
      this.unsignPlateIn,
      this.unsignPlateOut,
      this.feePaid,
      this.discount,
      this.vouchers,
      this.paymentTransactions,
      this.token,
      this.inUserName,
      this.inLaneName,
      this.outUserName,
      this.outLaneName,
      this.customerGroupName,
      this.cardGroupName,
      this.vehicleGroupName});

  PackingVehiceByCardNumberResponse.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    eventCode = json['EventCode'];
    cardNumber = json['CardNumber'];
    datetimeIn = json['DatetimeIn'];
    dateTimeOut = json['DateTimeOut'];
    if (json['ImagesIn'] != null) {
      imagesIn = <ImageResponse>[];
      json['ImagesIn'].forEach((v) {
        imagesIn!.add(ImageResponse.fromJson(v));
      });
    }
    if (json['ImagesOut'] != null) {
      imagesOut = <ImageResponse>[];
      json['ImagesOut'].forEach((v) {
        imagesOut!.add(ImageResponse.fromJson(v));
      });
    }

    laneIDIn = json['LaneIDIn'];
    laneIDOut = json['LaneIDOut'];
    userIDIn = json['UserIDIn'];
    userIDOut = json['UserIDOut'];
    plateIn = json['PlateIn'];
    plateOut = json['PlateOut'];
    registedPlate = json['RegistedPlate'];
    moneys = json['Moneys'];
    cardGroupID = json['CardGroupID'];
    vehicleGroupID = json['VehicleGroupID'];
    customerGroupID = json['CustomerGroupID'];
    customerName = json['CustomerName'];
    isBlackList = json['IsBlackList'];
    isFree = json['IsFree'];
    isDelete = json['IsDelete'];
    freeType = json['FreeType'];
    cardNo = json['CardNo'];
    description = json['Description'];
    paperTicketNumber = json['PaperTicketNumber'];
    isIncludePaperTicket = json['IsIncludePaperTicket'];
    unsignPlateIn = json['UnsignPlateIn'];
    unsignPlateOut = json['UnsignPlateOut'];
    feePaid = json['FeePaid'];
    discount = json['Discount'];
    vouchers = json['Vouchers'];
    if(json['PaymentTransactions'] != null) {
      paymentTransactions = json['PaymentTransactions'].cast<String>();
    }
    token = json['Token'];
    inUserName = json['InUserName'];
    inLaneName = json['InLaneName'];
    outUserName = json['OutUserName'];
    outLaneName = json['OutLaneName'];
    customerGroupName = json['CustomerGroupName'];
    cardGroupName = json['CardGroupName'];
    vehicleGroupName = json['VehicleGroupName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['EventCode'] = eventCode;
    data['CardNumber'] = cardNumber;
    data['DatetimeIn'] = datetimeIn;
    data['DateTimeOut'] = dateTimeOut;
    if (imagesIn != null) {
      data['ImagesIn'] = imagesIn!.map((v) => v.toJson()).toList();
    }
    if (imagesOut != null) {
      data['ImagesOut'] = imagesOut!.map((e) => e.toJson()).toList();
    }
    data['LaneIDIn'] = laneIDIn;
    data['LaneIDOut'] = laneIDOut;
    data['UserIDIn'] = userIDIn;
    data['UserIDOut'] = userIDOut;
    data['PlateIn'] = plateIn;
    data['PlateOut'] = plateOut;
    data['RegistedPlate'] = registedPlate;
    data['Moneys'] = moneys;
    data['CardGroupID'] = cardGroupID;
    data['VehicleGroupID'] = vehicleGroupID;
    data['CustomerGroupID'] = customerGroupID;
    data['CustomerName'] = customerName;
    data['IsBlackList'] = isBlackList;
    data['IsFree'] = isFree;
    data['IsDelete'] = isDelete;
    data['FreeType'] = freeType;
    data['CardNo'] = cardNo;
    data['Description'] = description;
    data['PaperTicketNumber'] = paperTicketNumber;
    data['IsIncludePaperTicket'] = isIncludePaperTicket;
    data['UnsignPlateIn'] = unsignPlateIn;
    data['UnsignPlateOut'] = unsignPlateOut;
    data['FeePaid'] = feePaid;
    data['Discount'] = discount;
    data['Vouchers'] = vouchers;
    data['PaymentTransactions'] = paymentTransactions;
    data['Token'] = token;
    data['InUserName'] = inUserName;
    data['InLaneName'] = inLaneName;
    data['OutUserName'] = outUserName;
    data['OutLaneName'] = outLaneName;
    data['CustomerGroupName'] = customerGroupName;
    data['CardGroupName'] = cardGroupName;
    data['VehicleGroupName'] = vehicleGroupName;
    return data;
  }
}

class ImageResponse {
  String? filePath;
  int? displayIndex;
  String? description;

  ImageResponse({this.filePath, this.displayIndex, this.description});

  ImageResponse.fromJson(Map<String, dynamic> json) {
    filePath = json["FilePath"];
    displayIndex = json["DisplayIndex"];
    description = json["Description"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["FilePath"] = filePath;
    data["DisplayIndex"] = displayIndex;
    data["Description"] = description;
    return data;
  }
}
