part of 'home_bloc.dart';

abstract class HomeState extends Equatable {}

class HomeStateInitial extends HomeState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class GetSystemConfigSuccess extends HomeState {
  final SystemConfig systemConfig;

  GetSystemConfigSuccess(this.systemConfig);

  @override
  // TODO: implement props
  List<Object?> get props => [systemConfig];
}

class GetLaneSuccess extends HomeState {
  final List<LaneClass> list;

  GetLaneSuccess(this.list);

  @override
  // TODO: implement props
  List<Object?> get props => [list];
}

class GetSystemConfigFailure extends HomeState {
  final String message;

  GetSystemConfigFailure(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
