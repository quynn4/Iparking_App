class SystemConfig {
  final PhysicalFileSetting physicalFileSetting;

  SystemConfig({
    required this.physicalFileSetting,
  });
}

class PhysicalFileSetting {
  final int type;
  final String endpoint;
  final String imageBucketName;
  final String accessKey;
  final String secretKey;
  final String host;
  final String eventInFilePath;
  final String eventOutFilePath;

  PhysicalFileSetting(
      {required this.type,
      required this.endpoint,
      required this.imageBucketName,
      required this.accessKey,
      required this.secretKey,
      required this.host,
      required this.eventInFilePath,
      required this.eventOutFilePath});
}
