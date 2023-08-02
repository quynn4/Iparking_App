part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetSystemConfigEvent extends HomeEvent {
  const GetSystemConfigEvent();
}

class GetLaneEvent extends HomeEvent {
  const GetLaneEvent();
}

class HomeStatusChanged extends HomeEvent {
  const HomeStatusChanged();
}