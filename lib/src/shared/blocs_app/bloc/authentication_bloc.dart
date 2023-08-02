import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ipacking_app/src/shared/blocs_app/loading_cubit/loading_cubit.dart';
import 'package:ipacking_app/src/shared/constants/enums_constants.dart';
import 'package:ipacking_app/src/shared/services/local_store_service.dart';
import 'package:ipacking_app/src/shared/usecases/usecase.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../feature/login/domain/usecases/check_auth.dart';
import '../../../feature/login/domain/usecases/logout.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoadingCubit loadingCubit;
  final LogOut logOut;
  final CheckAuth checkAuth;
  final LocalStorageService localStorageService;

  AuthenticationBloc(
      this.loadingCubit, this.logOut, this.checkAuth, this.localStorageService)
      : super(const AuthenticationState.unauthenticated()) {
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    on<AuthenticationCheckStatusRequested>(_onAuthenticationCheckRequested);
  }

  void _onAuthenticationStatusChanged(AuthenticationStatusChanged event,
      Emitter<AuthenticationState> emit) async {
    final currentAuth =
        (await localStorageService.getAuthInfo()).fold((l) => null, (r) => r);
    final accessToken = currentAuth?.token;
    if (event.status == AuthenticationStatus.authenticated &&
        accessToken != null &&
        !JwtDecoder.isExpired(accessToken)) {
      return emit(const AuthenticationState.authenticated());
    } else {
      await localStorageService.clearAuthInfo();
      return emit(const AuthenticationState.errAuthenticated());
    }
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    loadingCubit.showLoading();
    NoParams noParams = NoParams();
    await logOut(noParams);
    loadingCubit.hideLoading();
    emit(const AuthenticationState.unauthenticated());
  }

  void _onAuthenticationCheckRequested(AuthenticationCheckStatusRequested event,
      Emitter<AuthenticationState> emit) async {
    NoParams noParams = NoParams();
    final auth = await checkAuth(noParams);
    auth.fold((l) {
      emit(const AuthenticationState.unauthenticated());
    }, (r) {
      emit(const AuthenticationState.authenticated());
    });
  }
}
