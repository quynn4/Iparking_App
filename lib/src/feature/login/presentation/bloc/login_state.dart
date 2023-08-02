part of 'login_bloc.dart';



abstract class LoginState extends Equatable {}

class LoginStateInitial extends LoginState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoginSuccess extends LoginState {
  LoginSuccess();

  @override
  List<Object?> get props => [];
}

class LoginStateFailure extends LoginState {
  final String message;

  LoginStateFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class StoreUrlSuccess extends LoginState {
  StoreUrlSuccess();

  @override
  List<Object?> get props => [];
}
