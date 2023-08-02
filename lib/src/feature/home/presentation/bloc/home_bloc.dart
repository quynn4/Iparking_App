import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ipacking_app/src/feature/home/domain/entities/lane_class.dart';
import 'package:ipacking_app/src/feature/home/domain/entities/system_config.dart';
import 'package:ipacking_app/src/feature/home/domain/usecases/get_lane_usecase.dart';
import 'package:ipacking_app/src/feature/home/domain/usecases/get_system_config.dart';
import 'package:ipacking_app/src/shared/blocs_app/loading_cubit/loading_cubit.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LoadingCubit loadingCubit;
  final GetLaneUseCase getLaneUseCase;
  final GetSystemConfigUseCase getSystemConfigUseCase;

  HomeBloc(
    this.loadingCubit,
    this.getSystemConfigUseCase,
    this.getLaneUseCase,
  ) : super(HomeStateInitial()) {
    on<GetSystemConfigEvent>(_onGetSystemConfigEvent);
    on<GetLaneEvent>(_onGetLaneEvent);
    on<HomeStatusChanged>(_onHomeStatusChanged);
  }

  void _onHomeStatusChanged(
    HomeStatusChanged event,
    Emitter<HomeState> emit,
  ) {
    emit(HomeStateInitial());
  }

  void _onGetSystemConfigEvent(
    GetSystemConfigEvent event,
    Emitter<HomeState> emit,
  ) async {
    loadingCubit.showLoading();
    await getSystemConfigUseCase(true).then((value) {
      loadingCubit.hideLoading();
      value.fold((l) {
        emit(GetSystemConfigFailure(l.message));
      }, (r) {
        emit(GetSystemConfigSuccess(r));
      });
    });
  }

  void _onGetLaneEvent(
    GetLaneEvent event,
    Emitter<HomeState> emit,
  ) async {
    loadingCubit.showLoading();
    await getLaneUseCase(true).then((value) {
      loadingCubit.hideLoading();
      value.fold((l) {
        emit(GetSystemConfigFailure(l.message));
      }, (r) {
        emit(GetLaneSuccess(r));
      });
    });
  }
}
