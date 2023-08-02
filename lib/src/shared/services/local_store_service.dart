import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ipacking_app/src/shared/entitis/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../entitis/auth.dart';
import '../error/failures.dart';

class Key {
  static const String token = 'token';
  static const String url = 'url';
  static const String plateUrl = "plateUrl";
}

class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._internal();

  factory LocalStorageService() {
    return _instance;
  }

  LocalStorageService._internal();

  Future<Either<Failure, Auth>> getAuthInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(Key.token);

      if (token != null) {
        return Right(Auth(token: token));
      } else {
        return const Left(CacheFailure("Unauthorized"));
      }
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  Future<Either<Failure, StoreUrl>> getUrlInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final url = prefs.getString(Key.url);
      final plateUrl = prefs.getString(Key.plateUrl);
      if (url != null && plateUrl != null) {
        return Right(StoreUrl(url: url, plateUrl: plateUrl));
      } else {
        return const Left(CacheFailure("Can't store url"));
      }
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  Future<Either<Failure, Auth>> cacheAuthInfo({required String token}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(Key.token, token);

    return getAuthInfo();
  }

  Future<Either<Failure, StoreUrl>> cacheUrlInfo({required String? url, required String? plateUrl}) async {
    final prefs = await SharedPreferences.getInstance();
    if (url != null) {
      await prefs.setString(Key.url, url);
    }
    if (plateUrl != null) {
      await prefs.setString(Key.plateUrl, plateUrl);
    }
    return getUrlInfo();
  }

  Future<Either<Failure, Auth>> clearAuthInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(Key.token);
    return getAuthInfo();
  }

  Future<Either<Failure, StoreUrl>> clearUrlInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(Key.url);
    await prefs.remove(Key.plateUrl);
    return getUrlInfo();
  }

  Map<String, dynamic> parseJwt(String token) {
    final part = token.split('.');
    if (part.length != 3) {
      throw Exception('invalid token');
    }
    final payload = _decodeBase64(part[1]);
    final payloadMap = jsonDecode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }
    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');
    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!');
    }
    return utf8.decode(base64Url.decode(output));
  }

  Future<Either<Failure, UserInfo>> getCurrentUser() async {
    final currentAuth = await getAuthInfo();
    return currentAuth.fold((l) => Left(l), (r) {
      final claim = parseJwt(r.token);
      final String? id = claim[
          "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier"];
      return Right(UserInfo(id: id ?? ""));
    });
  }

  Future<Either<Failure, bool>> clearData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.clear();
      return const Right(true);
    } catch (e) {
      return Left(CacheFailure("$e"));
    }
  }
}
