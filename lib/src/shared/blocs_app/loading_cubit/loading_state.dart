part of 'loading_cubit.dart';

abstract class LoadingState {
  final bool? isLoading;

  LoadingState({this.isLoading});
}

class ShowLoading extends LoadingState {
  ShowLoading() : super(isLoading: true);
}

class HideLoading extends LoadingState {
  HideLoading() : super(isLoading: false);
}