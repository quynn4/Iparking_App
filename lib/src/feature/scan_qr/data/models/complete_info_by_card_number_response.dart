class CompleteInfoByCardNumberResponse {
  CardInfoResponse? cardInfo;
  CustomerInfoResponse? customerInfo;
  CardGroupInfoResponse? cardGroupInfo;
  CustomerGroupInfoResponse? customerGroupInfo;
  VehicleGroupInfoResponse? vehicleGroupInfo;

  CompleteInfoByCardNumberResponse(
      {this.cardInfo,
        this.customerInfo,
        this.cardGroupInfo,
        this.customerGroupInfo,
        this.vehicleGroupInfo});

  CompleteInfoByCardNumberResponse.fromJson(Map<String, dynamic> json) {
    cardInfo = json['CardInfo'] != null
        ? CardInfoResponse.fromJson(json['CardInfo'])
        : null;
    customerInfo = json['CustomerInfo'] != null
        ? CustomerInfoResponse.fromJson(json['CustomerInfo'])
        : null;
    cardGroupInfo = json['CardGroupInfo'] != null
        ? CardGroupInfoResponse.fromJson(json['CardGroupInfo'])
        : null;
    customerGroupInfo = json['CustomerGroupInfo'] != null
        ? CustomerGroupInfoResponse.fromJson(json['CustomerGroupInfo'])
        : null;
    vehicleGroupInfo = json['VehicleGroupInfo'] != null
        ? VehicleGroupInfoResponse.fromJson(json['VehicleGroupInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cardInfo != null) {
      data['CardInfo'] = cardInfo!.toJson();
    }
    if (customerInfo != null) {
      data['CustomerInfo'] = customerInfo!.toJson();
    }
    if (cardGroupInfo != null) {
      data['CardGroupInfo'] = cardGroupInfo!.toJson();
    }
    if (customerGroupInfo != null) {
      data['CustomerGroupInfo'] = customerGroupInfo!.toJson();
    }
    if (vehicleGroupInfo != null) {
      data['VehicleGroupInfo'] = vehicleGroupInfo!.toJson();
    }
    return data;
  }
}

class CardInfoResponse {
  String? id;
  String? cardID;
  String? cardNo;
  String? cardNumber;
  String? customerID;
  String? cardGroupID;
  String? importDate;
  String? expireDate;
  String? plate1;
  String? plateUnsign1;
  String? vehicleName1;
  String? plate2;
  String? plateUnsign2;
  String? vehicleName2;
  String? plate3;
  String? plateUnsign3;
  String? vehicleName3;
  bool? isLock;
  bool? isDelete;
  int? sortOrder;
  String? description;
  String? dateRegister;
  String? dateRelease;
  String? dateCancel;
  String? dateActive;
  String? accessExpireDate;
  String? accessLevelID;
  bool? chkRelease;
  bool? isAutoCapture;
  bool? isLost;
  String? keyword;

  CardInfoResponse(
      {this.id,
        this.cardID,
        this.cardNo,
        this.cardNumber,
        this.customerID,
        this.cardGroupID,
        this.importDate,
        this.expireDate,
        this.plate1,
        this.plateUnsign1,
        this.vehicleName1,
        this.plate2,
        this.plateUnsign2,
        this.vehicleName2,
        this.plate3,
        this.plateUnsign3,
        this.vehicleName3,
        this.isLock,
        this.isDelete,
        this.sortOrder,
        this.description,
        this.dateRegister,
        this.dateRelease,
        this.dateCancel,
        this.dateActive,
        this.accessExpireDate,
        this.accessLevelID,
        this.chkRelease,
        this.isAutoCapture,
        this.isLost,
        this.keyword});

  CardInfoResponse.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    cardID = json['CardID'];
    cardNo = json['CardNo'];
    cardNumber = json['CardNumber'];
    customerID = json['CustomerID'];
    cardGroupID = json['CardGroupID'];
    importDate = json['ImportDate'];
    expireDate = json['ExpireDate'];
    plate1 = json['Plate1'];
    plateUnsign1 = json['PlateUnsign1'];
    vehicleName1 = json['VehicleName1'];
    plate2 = json['Plate2'];
    plateUnsign2 = json['PlateUnsign2'];
    vehicleName2 = json['VehicleName2'];
    plate3 = json['Plate3'];
    plateUnsign3 = json['PlateUnsign3'];
    vehicleName3 = json['VehicleName3'];
    isLock = json['IsLock'];
    isDelete = json['IsDelete'];
    sortOrder = json['SortOrder'];
    description = json['Description'];
    dateRegister = json['DateRegister'];
    dateRelease = json['DateRelease'];
    dateCancel = json['DateCancel'];
    dateActive = json['DateActive'];
    accessExpireDate = json['AccessExpireDate'];
    accessLevelID = json['AccessLevelID'];
    chkRelease = json['ChkRelease'];
    isAutoCapture = json['isAutoCapture'];
    isLost = json['IsLost'];
    keyword = json['Keyword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['CardID'] = cardID;
    data['CardNo'] = cardNo;
    data['CardNumber'] = cardNumber;
    data['CustomerID'] = customerID;
    data['CardGroupID'] = cardGroupID;
    data['ImportDate'] = importDate;
    data['ExpireDate'] = expireDate;
    data['Plate1'] = plate1;
    data['PlateUnsign1'] = plateUnsign1;
    data['VehicleName1'] = vehicleName1;
    data['Plate2'] = plate2;
    data['PlateUnsign2'] = plateUnsign2;
    data['VehicleName2'] = vehicleName2;
    data['Plate3'] = plate3;
    data['PlateUnsign3'] = plateUnsign3;
    data['VehicleName3'] = vehicleName3;
    data['IsLock'] = isLock;
    data['IsDelete'] = isDelete;
    data['SortOrder'] = sortOrder;
    data['Description'] = description;
    data['DateRegister'] = dateRegister;
    data['DateRelease'] = dateRelease;
    data['DateCancel'] = dateCancel;
    data['DateActive'] = dateActive;
    data['AccessExpireDate'] = accessExpireDate;
    data['AccessLevelID'] = accessLevelID;
    data['ChkRelease'] = chkRelease;
    data['isAutoCapture'] = isAutoCapture;
    data['IsLost'] = isLost;
    data['Keyword'] = keyword;
    return data;
  }
}

class CustomerInfoResponse {
  String? id;
  String? customerID;
  String? customerCode;
  String? customerName;
  String? address;
  String? iDNumber;
  String? mobile;
  String? customerGroupID;
  String? description;
  bool? enableAccount;
  String? account;
  String? password;
  String? avatar;
  bool? inactive;
  int? sortOrder;
  String? compartmentId;
  String? accessLevelID;
  String? finger1;
  String? finger2;
  int? userIDofFinger;
  String? accessExpireDate;
  String? devPass;
  String? contractStartDate;
  String? contractEndDate;
  String? addressUnsign;
  String? mSPersonGroupId;
  int? userFaceId;
  String? plate1;
  String? plateUnsign1;
  String? vehicleName1;
  String? plate2;
  String? plateUnsign2;
  String? vehicleName2;
  String? plate3;
  String? plateUnsign3;
  String? vehicleName3;
  String? keyword;

  CustomerInfoResponse(
      {this.id,
        this.customerID,
        this.customerCode,
        this.customerName,
        this.address,
        this.iDNumber,
        this.mobile,
        this.customerGroupID,
        this.description,
        this.enableAccount,
        this.account,
        this.password,
        this.avatar,
        this.inactive,
        this.sortOrder,
        this.compartmentId,
        this.accessLevelID,
        this.finger1,
        this.finger2,
        this.userIDofFinger,
        this.accessExpireDate,
        this.devPass,
        this.contractStartDate,
        this.contractEndDate,
        this.addressUnsign,
        this.mSPersonGroupId,
        this.userFaceId,
        this.plate1,
        this.plateUnsign1,
        this.vehicleName1,
        this.plate2,
        this.plateUnsign2,
        this.vehicleName2,
        this.plate3,
        this.plateUnsign3,
        this.vehicleName3,
        this.keyword});

  CustomerInfoResponse.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    customerID = json['CustomerID'];
    customerCode = json['CustomerCode'];
    customerName = json['CustomerName'];
    address = json['Address'];
    iDNumber = json['IDNumber'];
    mobile = json['Mobile'];
    customerGroupID = json['CustomerGroupID'];
    description = json['Description'];
    enableAccount = json['EnableAccount'];
    account = json['Account'];
    password = json['Password'];
    avatar = json['Avatar'];
    inactive = json['Inactive'];
    sortOrder = json['SortOrder'];
    compartmentId = json['CompartmentId'];
    accessLevelID = json['AccessLevelID'];
    finger1 = json['Finger1'];
    finger2 = json['Finger2'];
    userIDofFinger = json['UserIDofFinger'];
    accessExpireDate = json['AccessExpireDate'];
    devPass = json['DevPass'];
    contractStartDate = json['ContractStartDate'];
    contractEndDate = json['ContractEndDate'];
    addressUnsign = json['AddressUnsign'];
    mSPersonGroupId = json['MS_PersonGroupId'];
    userFaceId = json['UserFaceId'];
    plate1 = json['Plate1'];
    plateUnsign1 = json['PlateUnsign1'];
    vehicleName1 = json['VehicleName1'];
    plate2 = json['Plate2'];
    plateUnsign2 = json['PlateUnsign2'];
    vehicleName2 = json['VehicleName2'];
    plate3 = json['Plate3'];
    plateUnsign3 = json['PlateUnsign3'];
    vehicleName3 = json['VehicleName3'];
    keyword = json['Keyword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['CustomerID'] = customerID;
    data['CustomerCode'] = customerCode;
    data['CustomerName'] = customerName;
    data['Address'] = address;
    data['IDNumber'] = iDNumber;
    data['Mobile'] = mobile;
    data['CustomerGroupID'] = customerGroupID;
    data['Description'] = description;
    data['EnableAccount'] = enableAccount;
    data['Account'] = account;
    data['Password'] = password;
    data['Avatar'] = avatar;
    data['Inactive'] = inactive;
    data['SortOrder'] = sortOrder;
    data['CompartmentId'] = compartmentId;
    data['AccessLevelID'] = accessLevelID;
    data['Finger1'] = finger1;
    data['Finger2'] = finger2;
    data['UserIDofFinger'] = userIDofFinger;
    data['AccessExpireDate'] = accessExpireDate;
    data['DevPass'] = devPass;
    data['ContractStartDate'] = contractStartDate;
    data['ContractEndDate'] = contractEndDate;
    data['AddressUnsign'] = addressUnsign;
    data['MS_PersonGroupId'] = mSPersonGroupId;
    data['UserFaceId'] = userFaceId;
    data['Plate1'] = plate1;
    data['PlateUnsign1'] = plateUnsign1;
    data['VehicleName1'] = vehicleName1;
    data['Plate2'] = plate2;
    data['PlateUnsign2'] = plateUnsign2;
    data['VehicleName2'] = vehicleName2;
    data['Plate3'] = plate3;
    data['PlateUnsign3'] = plateUnsign3;
    data['VehicleName3'] = vehicleName3;
    data['Keyword'] = keyword;
    return data;
  }
}

class CardGroupInfoResponse {
  String? id;
  String? cardGroupID;
  String? cardGroupCode;
  String? cardGroupName;
  String? description;
  int? cardType;
  String? vehicleGroupID;
  String? laneIDs;
  String? dayTimeFrom;
  String? dayTimeTo;
  int? formulation;
  int? eachFee;
  int? block0;
  int? time0;
  int? block1;
  int? time1;
  int? block2;
  int? time2;
  int? block3;
  int? time3;
  int? block4;
  int? time4;
  int? block5;
  int? time5;
  String? timePeriods;
  String? costs;
  bool? inactive;
  int? sortOrder;
  bool? isHaveMoneyExcessTime;
  bool? enableFree;
  int? freeTime;
  bool? isCheckPlate;
  bool? isHaveMoneyExpiredDate;

  CardGroupInfoResponse(
      {this.id,
        this.cardGroupID,
        this.cardGroupCode,
        this.cardGroupName,
        this.description,
        this.cardType,
        this.vehicleGroupID,
        this.laneIDs,
        this.dayTimeFrom,
        this.dayTimeTo,
        this.formulation,
        this.eachFee,
        this.block0,
        this.time0,
        this.block1,
        this.time1,
        this.block2,
        this.time2,
        this.block3,
        this.time3,
        this.block4,
        this.time4,
        this.block5,
        this.time5,
        this.timePeriods,
        this.costs,
        this.inactive,
        this.sortOrder,
        this.isHaveMoneyExcessTime,
        this.enableFree,
        this.freeTime,
        this.isCheckPlate,
        this.isHaveMoneyExpiredDate});

  CardGroupInfoResponse.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    cardGroupID = json['CardGroupID'];
    cardGroupCode = json['CardGroupCode'];
    cardGroupName = json['CardGroupName'];
    description = json['Description'];
    cardType = json['CardType'];
    vehicleGroupID = json['VehicleGroupID'];
    laneIDs = json['LaneIDs'];
    dayTimeFrom = json['DayTimeFrom'];
    dayTimeTo = json['DayTimeTo'];
    formulation = json['Formulation'];
    eachFee = json['EachFee'];
    block0 = json['Block0'];
    time0 = json['Time0'];
    block1 = json['Block1'];
    time1 = json['Time1'];
    block2 = json['Block2'];
    time2 = json['Time2'];
    block3 = json['Block3'];
    time3 = json['Time3'];
    block4 = json['Block4'];
    time4 = json['Time4'];
    block5 = json['Block5'];
    time5 = json['Time5'];
    timePeriods = json['TimePeriods'];
    costs = json['Costs'];
    inactive = json['Inactive'];
    sortOrder = json['SortOrder'];
    isHaveMoneyExcessTime = json['IsHaveMoneyExcessTime'];
    enableFree = json['EnableFree'];
    freeTime = json['FreeTime'];
    isCheckPlate = json['IsCheckPlate'];
    isHaveMoneyExpiredDate = json['IsHaveMoneyExpiredDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['CardGroupID'] = cardGroupID;
    data['CardGroupCode'] = cardGroupCode;
    data['CardGroupName'] = cardGroupName;
    data['Description'] = description;
    data['CardType'] = cardType;
    data['VehicleGroupID'] = vehicleGroupID;
    data['LaneIDs'] = laneIDs;
    data['DayTimeFrom'] = dayTimeFrom;
    data['DayTimeTo'] = dayTimeTo;
    data['Formulation'] = formulation;
    data['EachFee'] = eachFee;
    data['Block0'] = block0;
    data['Time0'] = time0;
    data['Block1'] = block1;
    data['Time1'] = time1;
    data['Block2'] = block2;
    data['Time2'] = time2;
    data['Block3'] = block3;
    data['Time3'] = time3;
    data['Block4'] = block4;
    data['Time4'] = time4;
    data['Block5'] = block5;
    data['Time5'] = time5;
    data['TimePeriods'] = timePeriods;
    data['Costs'] = costs;
    data['Inactive'] = inactive;
    data['SortOrder'] = sortOrder;
    data['IsHaveMoneyExcessTime'] = isHaveMoneyExcessTime;
    data['EnableFree'] = enableFree;
    data['FreeTime'] = freeTime;
    data['IsCheckPlate'] = isCheckPlate;
    data['IsHaveMoneyExpiredDate'] = isHaveMoneyExpiredDate;
    return data;
  }
}

class CustomerGroupInfoResponse {
  String? id;
  String? customerGroupID;
  String? parentID;
  String? customerGroupCode;
  String? customerGroupName;
  String? description;
  bool? inactive;
  int? sortOrder;
  int? ordering;
  String? tax;
  bool? isCompany;

  CustomerGroupInfoResponse(
      {this.id,
        this.customerGroupID,
        this.parentID,
        this.customerGroupCode,
        this.customerGroupName,
        this.description,
        this.inactive,
        this.sortOrder,
        this.ordering,
        this.tax,
        this.isCompany});

  CustomerGroupInfoResponse.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    customerGroupID = json['CustomerGroupID'];
    parentID = json['ParentID'];
    customerGroupCode = json['CustomerGroupCode'];
    customerGroupName = json['CustomerGroupName'];
    description = json['Description'];
    inactive = json['Inactive'];
    sortOrder = json['SortOrder'];
    ordering = json['Ordering'];
    tax = json['Tax'];
    isCompany = json['IsCompany'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['CustomerGroupID'] = customerGroupID;
    data['ParentID'] = parentID;
    data['CustomerGroupCode'] = customerGroupCode;
    data['CustomerGroupName'] = customerGroupName;
    data['Description'] = description;
    data['Inactive'] = inactive;
    data['SortOrder'] = sortOrder;
    data['Ordering'] = ordering;
    data['Tax'] = tax;
    data['IsCompany'] = isCompany;
    return data;
  }
}

class VehicleGroupInfoResponse {
  String? id;
  String? vehicleGroupID;
  String? vehicleGroupCode;
  String? vehicleGroupName;
  int? vehicleType;
  int? limitNumber;
  bool? inactive;
  int? sortOrder;

  VehicleGroupInfoResponse(
      {this.id,
        this.vehicleGroupID,
        this.vehicleGroupCode,
        this.vehicleGroupName,
        this.vehicleType,
        this.limitNumber,
        this.inactive,
        this.sortOrder});

  VehicleGroupInfoResponse.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    vehicleGroupID = json['VehicleGroupID'];
    vehicleGroupCode = json['VehicleGroupCode'];
    vehicleGroupName = json['VehicleGroupName'];
    vehicleType = json['VehicleType'];
    limitNumber = json['LimitNumber'];
    inactive = json['Inactive'];
    sortOrder = json['SortOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['VehicleGroupID'] = vehicleGroupID;
    data['VehicleGroupCode'] = vehicleGroupCode;
    data['VehicleGroupName'] = vehicleGroupName;
    data['VehicleType'] = vehicleType;
    data['LimitNumber'] = limitNumber;
    data['Inactive'] = inactive;
    data['SortOrder'] = sortOrder;
    return data;
  }
}
