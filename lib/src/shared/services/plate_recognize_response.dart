class PlateRecognizeResponse {
  String? filename;
  String? timestamp;
  int? cameraId;
  List<Results>? results;
  String? error;
  double? processingTime;

  PlateRecognizeResponse(
      {this.filename,
      this.timestamp,
      this.cameraId,
      this.results,
      this.error,
      this.processingTime});

  PlateRecognizeResponse.fromJson(Map<String, dynamic> json) {
    filename = json['filename'];
    timestamp = json['timestamp'];
    cameraId = json['camera_id'];
    error = json['error'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
    processingTime = json['processing_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['filename'] = filename;
    data['error'] = error;
    data['timestamp'] = timestamp;
    data['camera_id'] = cameraId;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['processing_time'] = processingTime;
    return data;
  }
}

class Results {
  String? plate;

  Results({
    this.plate,
  });

  Results.fromJson(Map<String, dynamic> json) {
    plate = json['plate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['plate'] = plate;
    return data;
  }
}
