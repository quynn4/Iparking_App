part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginSubmitted extends LoginEvent {
  final LoginDTO loginDTO;

  const LoginSubmitted(this.loginDTO);

  @override
  List<Object> get props => [loginDTO];
}

class StoreUrl extends LoginEvent {
  final String url;
  final String plateUrl;

  const StoreUrl(this.url, this.plateUrl);

  @override
  List<Object> get props => [url];
}

class LoginStatusChanged extends LoginEvent {
  const LoginStatusChanged();
}
