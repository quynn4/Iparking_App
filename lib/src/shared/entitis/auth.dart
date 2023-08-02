import 'package:equatable/equatable.dart';

class Auth extends Equatable {
  final String token;

  const Auth({required this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() {
    return "Auth{token: $token}";
  }
}

class StoreUrl extends Equatable {
  final String url;
  final String plateUrl;

  const StoreUrl({required this.url, required this.plateUrl});

  @override
  List<Object> get props => [url, plateUrl];
}
