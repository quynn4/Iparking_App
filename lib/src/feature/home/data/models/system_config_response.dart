class SystemConfigResponse {
  PhysicalFileSettingResponse? physicalFileSetting;

  SystemConfigResponse({this.physicalFileSetting});

  SystemConfigResponse.fromJson(Map<String, dynamic> json) {
    physicalFileSetting = json['PhysicalFileSetting'] != null
        ? PhysicalFileSettingResponse.fromJson(json['PhysicalFileSetting'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (physicalFileSetting != null) {
      data['PhysicalFileSetting'] = physicalFileSetting!.toJson();
    }
    return data;
  }
}

class PhysicalFileSettingResponse {
  int? type;
  String? endpoint;
  String? imageBucketName;
  String? accessKey;
  String? secretKey;
  String? host;
  String? eventInFilePath;
  String? eventOutFilePath;

  PhysicalFileSettingResponse(
      {this.type,
        this.endpoint,
        this.imageBucketName,
        this.accessKey,
        this.secretKey,
        this.host,
        this.eventInFilePath,
        this.eventOutFilePath});

  PhysicalFileSettingResponse.fromJson(Map<String, dynamic> json) {
    type = json['Type'];
    endpoint = json['Endpoint'];
    imageBucketName = json['ImageBucketName'];
    accessKey = json['AccessKey'];
    secretKey = json['SecretKey'];
    host = json['Host'];
    eventInFilePath = json['EventInFilePath'];
    eventOutFilePath = json['EventOutFilePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Type'] = type;
    data['Endpoint'] = endpoint;
    data['ImageBucketName'] = imageBucketName;
    data['AccessKey'] = accessKey;
    data['SecretKey'] = secretKey;
    data['Host'] = host;
    data['EventInFilePath'] = eventInFilePath;
    data['EventOutFilePath'] = eventOutFilePath;
    return data;
  }
}
