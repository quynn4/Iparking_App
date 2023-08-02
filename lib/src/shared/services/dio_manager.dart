import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../env.dart';
import '../../../generated/l10n.dart';
import '../../../injection_container.dart';
import '../blocs_app/bloc/authentication_bloc.dart';
import '../constants/enums_constants.dart';
import '../error/error_data.dart';
import '../network/config_network.dart';
import '../network/network_info.dart';
import 'local_store_service.dart';

class DioManager {
  final LocalStorageService localService;
  final NetworkInfo networkInfo;
  late Dio dio;

  DioManager(this.localService, this.networkInfo) {
    BaseOptions? options = BaseOptions(
      contentType: ConfigNetwork.contentType,
      receiveDataWhenStatusError: true,
      connectTimeout:
          const Duration(milliseconds: ConfigNetwork.connectTimeout),
      receiveTimeout:
          const Duration(milliseconds: ConfigNetwork.receiveTimeout),
    );
    dio = Dio(options);
    if (isDebug) {
      dio.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          compact: true));
    }
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (option, handler) async {
      bool isConnected = await networkInfo.isConnected;
      if (isConnected) {
        final storeUrl = (await localService.getUrlInfo()).fold((l) => null, (r) => r);
        if(storeUrl != null) {
          option.baseUrl = storeUrl.url;
        }
        final tokens =
            (await localService.getAuthInfo()).fold((l) => null, (r) => r);
        if (tokens != null) {
          option.headers['Authorization'] = 'Bearer ${tokens.token}';
        }
        return handler.next(option);
      }
    }, onResponse: (response, handler) async {
      return handler.next(response);
    }, onError: (error, handler) async {
      return await onErrorHandler(error, handler);
    }));
  }

  // Future<Response> _retry(RequestOptions requestOptions, Auth? auth) async {
  //   dio.options.baseUrl = requestOptions.baseUrl;
  //   requestOptions.headers['Authorization'] = 'Bearer ${auth?.token}';
  //   final options = Options(
  //     contentType: ConfigNetwork.contentType,
  //     receiveDataWhenStatusError: true,
  //     receiveTimeout:
  //         const Duration(milliseconds: ConfigNetwork.receiveTimeout),
  //     method: requestOptions.method,
  //     headers: requestOptions.headers,
  //   );
  //   return dio.request(requestOptions.path,
  //       data: requestOptions.data,
  //       queryParameters: requestOptions.queryParameters,
  //       options: options);
  // }

  bool isNotLoginPath(String path) {
    if (path != "api/login") {
      return true;
    } else {
      return false;
    }
  }

  Future handleUnauthorizedError(
      DioException error, ErrorInterceptorHandler handler) async {
    final requestOptions = error.requestOptions;
    if (error.response?.statusCode != 401) {
      return handler.reject(getRawError(error));
    }
    if (!isNotLoginPath(requestOptions.path)) {
      return handler.reject(getRawError(error));
    }
    final currentAuth =
        (await localService.getAuthInfo()).fold((l) => null, (r) => r);
    if (currentAuth != null) {
      try {
        getIt<AuthenticationBloc>().add(const AuthenticationStatusChanged(
            AuthenticationStatus.errAuthenticated));
        return handler.next(getRawError(error));
      } catch (e) {
        print("Error: $e");
      }
    }
    return handler.next(getRawError(error));
  }

  Future onErrorHandler(DioException error, ErrorInterceptorHandler handler) async {
    Response? rawErrResponse = error.response;
    try {
      if (rawErrResponse != null) {
        if (rawErrResponse.statusCode == 401) {
          final result = await handleUnauthorizedError(error, handler);
          return result;
        } else {
          return handler.next(getRawError(error));
        }
      }
    } catch (_) {}

    return handler.reject(error);
  }

  DioException getRawError(DioException error) {
    final request = error.requestOptions;
    final formattedErrResponse = getFormattedErrorResponse(error);
    final response = Response(
        data: error.response?.data,
        requestOptions: request,
        statusCode: error.response?.statusCode,
        statusMessage: formattedErrResponse.message);
    return DioException(
        requestOptions: request,
        response: response,
        error: formattedErrResponse.message);
  }

  ErrorResponse getFormattedErrorResponse(DioException error) {
    final rawErrResponse = error.response;
    return ErrorResponse(rawErrResponse);
  }
}

class ErrorResponse {
  String? code;
  String? extra;
  dynamic data;

  String get message {
    return getMessageErrorFromErrorCode();
  }

  ErrorResponse(Response? errResponse) {
    var dataFormatted = errResponse?.data;
    if (dataFormatted is String) {
      dataFormatted = json.decode(dataFormatted.trim());
    }

    code = dataFormatted?['message'];
    extra = dataFormatted?['extra'].toString();
    data = errResponse?.data;
  }

  String getMessageErrorFromErrorCode() {
    try {
      if (errorData.containsKey(code)) {
        if (isDebug) {
          return errorData[code];
          //+ "\n" + extraErr + "\n" + message;
        }
        return errorData[code];
      } else {
        return S.current.err_server_unknown;
      }
    } catch (e) {
      return S.current.err_server_unknown;
    }
  }
}
