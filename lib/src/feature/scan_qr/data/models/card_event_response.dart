class CardEventResponse {
  String? id;
  String? eventCode;

  CardEventResponse({this.id, this.eventCode});

  CardEventResponse.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    eventCode = json['EventCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['EventCode'] = eventCode;
    return data;
  }
}
