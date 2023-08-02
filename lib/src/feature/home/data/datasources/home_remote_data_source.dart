import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ipacking_app/src/feature/home/data/models/lane_response.dart';
import 'package:ipacking_app/src/feature/home/data/models/system_config_response.dart';
import 'package:ipacking_app/src/feature/home/domain/entities/lane_class.dart';
import 'package:ipacking_app/src/feature/home/domain/entities/system_config.dart';
import 'package:ipacking_app/src/shared/error/failures.dart';
import 'package:ipacking_app/src/shared/network/network_info.dart';
import 'package:ipacking_app/src/shared/services/rest_api_service.dart';

class HomeRemoteDataSource {
  final RestClient _client;
  final NetworkInfo _networkInfo;

  HomeRemoteDataSource(this._client, this._networkInfo);

  Future<Either<Failure, SystemConfig>> getSystemConfig() async {
    try {
      bool isConnected = await _networkInfo.isConnected;
      if (isConnected) {
        final requestResponse = await _client.getSystemConfig();
        if (requestResponse.statusCode == 200) {
          final String result = requestResponse.result ?? "";
          Map<String, dynamic> map = jsonDecode(result);
          final SystemConfigResponse response =
              SystemConfigResponse.fromJson(map);
          return Right(_getSystemConfigResponse(response));
        } else {
          return Left(ServerFailure(requestResponse.message ?? ""));
        }
      } else {
        return Left(NoNetworkError());
      }
    } catch (e) {
      switch (e.runtimeType) {
        case DioException:
          final res = (e as DioException).response;
          return Left(ServerFailure(res?.statusMessage ?? e.message ?? ""));
        default:
          return Left(ServerFailure(e.toString()));
      }
    }
  }

  Future<Either<Failure, List<LaneClass>>> getLane() async {
    try {
      bool isConnected = await _networkInfo.isConnected;
      if (isConnected) {
        final requestResponse = await _client.getLane();
        if (requestResponse.statusCode == 200) {
          final String result = requestResponse.result ?? "";
          Map<String, dynamic> map = jsonDecode("{\"result\": $result }");

          final ListLaneResponse response = ListLaneResponse.fromJson(map);
          return Right(_getListLane(response));
        } else {
          return Left(ServerFailure(requestResponse.message ?? ""));
        }
      } else {
        return Left(NoNetworkError());
      }
    } catch (e) {
      switch (e.runtimeType) {
        case DioException:
          final res = (e as DioException).response;
          return Left(ServerFailure(res?.statusMessage ?? e.message ?? ""));
        default:
          return Left(ServerFailure(e.toString()));
      }
    }
  }
}

SystemConfig _getSystemConfigResponse(SystemConfigResponse? response) {
  if (response != null) {
    return SystemConfig(
      physicalFileSetting:
          _getPhysicalFileSetting(response.physicalFileSetting),
    );
  } else {
    return SystemConfig(
      physicalFileSetting: _getPhysicalFileSetting(null),
    );
  }
}

List<LaneClass> _getListLane(ListLaneResponse? response) {
  List<LaneClass> listLane = [];
  if (response != null) {
    final List<LaneResponse>? list = response.result;
    if (list != null && list.isNotEmpty) {
      for (var element in list) {
        listLane.add(_getLaneFromResponse(element));
      }
    }
  }
  return listLane;
}

LaneClass _getLaneFromResponse(LaneResponse? laneResponse) {
  if (laneResponse != null) {
    return LaneClass(
      id: laneResponse.id ?? "",
      laneId: laneResponse.laneID ?? "",
      laneType: laneResponse.laneType ?? 0,
    );
  } else {
    return LaneClass(
      id: "",
      laneId: "",
      laneType: 0,
    );
  }
}

PhysicalFileSetting _getPhysicalFileSetting(
    PhysicalFileSettingResponse? response) {
  if (response != null) {
    return PhysicalFileSetting(
      type: response.type ?? 0,
      endpoint: response.endpoint ?? "",
      imageBucketName: response.imageBucketName ?? "",
      accessKey: response.accessKey ?? "",
      secretKey: response.secretKey ?? "",
      host: response.host ?? "",
      eventInFilePath: response.eventInFilePath ?? "",
      eventOutFilePath: response.eventOutFilePath ?? "",
    );
  } else {
    return PhysicalFileSetting(
      type: 0,
      endpoint: "",
      imageBucketName: "",
      accessKey: "",
      secretKey: "",
      host: "",
      eventInFilePath: "",
      eventOutFilePath: "",
    );
  }
}
