part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;

  const AuthenticationState._({this.status = AuthenticationStatus.unknown});

  const AuthenticationState.authenticated()
      : this._(status: AuthenticationStatus.authenticated);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  const AuthenticationState.errAuthenticated()
      : this._(status: AuthenticationStatus.errAuthenticated);

  @override
  // TODO: implement props
  List<Object?> get props => [status];

}
