import 'package:ipacking_app/src/feature/scan_qr/domain/entities/packing_vehice_by_card_number.dart';

class CreateCardByIdDTO {
  String? eventCode;
  String? cardNo;
  String? registedPlate;
  String? customerName;
  String? plateIn;
  List<ImageClass>? imagesIn;
  String? datetimeIn;
  String? userIDIn;
  String? laneIDIn;
  String? cardGroupID;
  String? vehicleGroupID;
  String? customerGroupID;
  String? cardNumber;

  CreateCardByIdDTO(
      {this.eventCode,
      this.cardNo,
      this.registedPlate,
      this.customerName,
      this.plateIn,
      this.imagesIn,
      this.datetimeIn,
      this.userIDIn,
      this.laneIDIn,
      this.cardGroupID,
      this.vehicleGroupID,
      this.customerGroupID,
      this.cardNumber});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['eventCode'] = eventCode;
    data['cardNo'] = cardNo;
    data['registedPlate'] = registedPlate;
    data['customerName'] = customerName;
    data['plateIn'] = plateIn;
    if (imagesIn != null) {
      data['imagesIn'] = imagesIn!.map((v) => v.toJson()).toList();
    }
    data['DatetimeIn'] = datetimeIn;
    data['UserIDIn'] = userIDIn;
    data['LaneIDIn'] = laneIDIn;
    data['CardGroupID'] = cardGroupID;
    data['VehicleGroupID'] = vehicleGroupID;
    data['CustomerGroupID'] = customerGroupID;
    data['CardNumber'] = cardNumber;
    return data;
  }
}
