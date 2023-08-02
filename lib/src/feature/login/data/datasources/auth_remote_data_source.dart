import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../shared/entitis/auth.dart';
import '../../../../shared/error/failures.dart';
import '../../../../shared/network/network_info.dart';
import '../../../../shared/services/rest_api_service.dart';
import '../../domain/entities/login_dto.dart';
import '../models/login_response.dart';

class AuthRemoteDataSource {
  final RestClient _client;
  final NetworkInfo _networkInfo;

  AuthRemoteDataSource(this._client, this._networkInfo);

  Future<Either<Failure, Auth>> loginWithEmail(LoginDTO loginDTO) async {
    try {
      bool isConnected = await _networkInfo.isConnected;
      if (isConnected) {
        final requestResponse = await _client.loginEmail(loginDTO);
        if (requestResponse.statusCode == 200) {
          final String result = requestResponse.result ?? "";
          Map<String, dynamic> map = jsonDecode(result);
          final LoginResponse response = LoginResponse.fromJson(map);
          return Right(_getAuthFromResponse(response));
        } else {
          return Left(ServerFailure(requestResponse.message ?? ""));
        }
      } else {
        return Left(NoNetworkError());
      }
    } catch (e) {
      switch (e.runtimeType) {
        case DioError:
          final res = (e as DioError).response;
          return Left(ServerFailure(res?.statusMessage ?? e.message ?? ""));
        default:
          return Left(ServerFailure(e.toString()));
      }
    }
  }

  Auth _getAuthFromResponse(LoginResponse? response) {
    if (response != null) {
      return Auth(token: response.token ?? "");
    } else {
      return const Auth(token: "");
    }
  }
}
