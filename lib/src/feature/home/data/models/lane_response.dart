class ListLaneResponse {
  List<LaneResponse>? result;

  ListLaneResponse({this.result});

  ListLaneResponse.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <LaneResponse>[];
      json['result'].forEach((v) {
        result!.add(LaneResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class LaneResponse {
  String? id;
  String? laneID;
  int? laneType;

  LaneResponse({this.id, this.laneID, this.laneType});

  LaneResponse.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    laneID = json['LaneID'];
    laneType = json['LaneType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['Id'] = id;
    data['LaneID'] = laneID;
    data['LaneType'] = laneType;
    return data;
  }
}
