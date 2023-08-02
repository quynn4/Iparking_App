class CompleteInfoByCardNumber {
  final CardInfo cardInfo;
  final CardGroupInfo cardGroupInfo;
  final VehicleGroupInfo vehicleGroupInfo;
  final CustomerGroupInfo customerGroupInfo;

  CompleteInfoByCardNumber({
    required this.cardInfo,
    required this.cardGroupInfo,
    required this.vehicleGroupInfo,
    required this.customerGroupInfo,
  });
}

class VehicleGroupInfo {
  final String id;
  final String vehicleGroupID;
  final String vehicleGroupCode;
  final String vehicleGroupName;
  final int vehicleType;
  final int limitNumber;
  final bool inactive;
  final int sortOrder;

  VehicleGroupInfo(
      {required this.id,
      required this.vehicleGroupID,
      required this.vehicleGroupCode,
      required this.vehicleGroupName,
      required this.vehicleType,
      required this.limitNumber,
      required this.inactive,
      required this.sortOrder});
}

class CardGroupInfo {
  final String id;
  final String cardGroupID;
  final String cardGroupCode;
  final String cardGroupName;
  final String description;
  final int cardType;
  final String vehicleGroupID;
  final String laneIDs;
  final String dayTimeFrom;
  final String dayTimeTo;
  final int formulation;
  final int eachFee;
  final int block0;
  final int time0;
  final int block1;
  final int time1;
  final int block2;
  final int time2;
  final int block3;
  final int time3;
  final int block4;
  final int time4;
  final int block5;
  final int time5;
  final String timePeriods;
  final String costs;
  final bool inactive;
  final int sortOrder;
  final bool isHaveMoneyExcessTime;
  final bool enableFree;
  final int freeTime;
  final bool isCheckPlate;
  final bool isHaveMoneyExpiredDate;

  CardGroupInfo(
      {required this.id,
      required this.cardGroupID,
      required this.cardGroupCode,
      required this.cardGroupName,
      required this.description,
      required this.cardType,
      required this.vehicleGroupID,
      required this.laneIDs,
      required this.dayTimeFrom,
      required this.dayTimeTo,
      required this.formulation,
      required this.eachFee,
      required this.block0,
      required this.time0,
      required this.block1,
      required this.time1,
      required this.block2,
      required this.time2,
      required this.block3,
      required this.time3,
      required this.block4,
      required this.time4,
      required this.block5,
      required this.time5,
      required this.timePeriods,
      required this.costs,
      required this.inactive,
      required this.sortOrder,
      required this.isHaveMoneyExcessTime,
      required this.enableFree,
      required this.freeTime,
      required this.isCheckPlate,
      required this.isHaveMoneyExpiredDate});
}

class CardInfo {
  final String id;
  final String cardID;
  final String cardNo;
  final String cardNumber;
  final String customerID;
  final String cardGroupID;
  final String importDate;
  final String expireDate;
  final String plate1;
  final String plateUnsign1;
  final String vehicleName1;
  final String plate2;
  final String plateUnsign2;
  final String vehicleName2;
  final String plate3;
  final String plateUnsign3;
  final String vehicleName3;
  final bool isLock;
  final bool isDelete;
  final int sortOrder;
  final String description;
  final String dateRegister;
  final String dateRelease;
  final String dateCancel;
  final String dateActive;
  final String accessExpireDate;
  final String accessLevelID;
  final bool chkRelease;
  final bool isAutoCapture;
  final bool isLost;

  CardInfo(
      {required this.id,
      required this.cardID,
      required this.cardNo,
      required this.cardNumber,
      required this.customerID,
      required this.cardGroupID,
      required this.importDate,
      required this.expireDate,
      required this.plate1,
      required this.plateUnsign1,
      required this.vehicleName1,
      required this.plate2,
      required this.plateUnsign2,
      required this.vehicleName2,
      required this.plate3,
      required this.plateUnsign3,
      required this.vehicleName3,
      required this.isLock,
      required this.isDelete,
      required this.sortOrder,
      required this.description,
      required this.dateRegister,
      required this.dateRelease,
      required this.dateCancel,
      required this.dateActive,
      required this.accessExpireDate,
      required this.accessLevelID,
      required this.chkRelease,
      required this.isAutoCapture,
      required this.isLost});
}

class CustomerGroupInfo {
  final String id;
  final String customerGroupID;
  final String parentID;
  final String customerGroupCode;
  final String customerGroupName;
  final String description;
  final bool inactive;
  final int sortOrder;
  final int ordering;
  final String tax;
  final bool isCompany;

  CustomerGroupInfo(
      {required this.id,
      required this.customerGroupID,
      required this.parentID,
      required this.customerGroupCode,
      required this.customerGroupName,
      required this.description,
      required this.inactive,
      required this.sortOrder,
      required this.ordering,
      required this.tax,
      required this.isCompany});
}
