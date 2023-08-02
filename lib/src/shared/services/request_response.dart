class RequestResponse {
  int? statusCode;
  String? message;
  String? version;
  String? result;
  String? serverTime;

  RequestResponse(
      {this.statusCode,
        this.message,
        this.version,
        this.result,
        this.serverTime});

  RequestResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    version = json['version'];
    result = json['result'];
    serverTime = json['serverTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    data['version'] = version;
    data['result'] = result;
    data['serverTime'] = serverTime;
    return data;
  }
}