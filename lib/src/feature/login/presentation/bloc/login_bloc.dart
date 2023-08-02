import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../injection_container.dart';
import '../../../../shared/blocs_app/loading_cubit/loading_cubit.dart';
import '../../../../shared/services/local_store_service.dart';
import '../../domain/entities/login_dto.dart';
import '../../domain/usecases/login_with_email.dart';


part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoadingCubit loadingCubit;
  final LoginWithEmail loginWithEmail;

  LoginBloc(this.loadingCubit, this.loginWithEmail)
      : super(LoginStateInitial()) {
    on<LoginSubmitted>(_onSubmitted);
    on<LoginStatusChanged>(_onStatusChanged);
    on<StoreUrl>(_onStoreUrl);
  }

  void _onStatusChanged(
    LoginStatusChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(LoginStateInitial());
  }

  void _onStoreUrl(
    StoreUrl event,
    Emitter<LoginState> emit,
  ) async {
    await getIt<LocalStorageService>()
        .cacheUrlInfo(url: event.url, plateUrl: event.plateUrl)
        .then((value) {
      value.fold((l) {
        emit(LoginStateFailure("Không thể lưu địa chỉ IP"));
      }, (r) {
        emit(StoreUrlSuccess());
      });
    });
  }

  void _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    loadingCubit.showLoading();
    await loginWithEmail(event.loginDTO).then((loginResult) {
      loadingCubit.hideLoading();
      loginResult.fold((l) {
        emit(LoginStateFailure(l.message));
      }, (r) {
        emit(LoginSuccess());
      });
    });
  }
}
