import 'package:flutter_bloc/flutter_bloc.dart';

part 'loading_state.dart';

class LoadingCubit extends Cubit<LoadingState> {
  LoadingCubit() : super(HideLoading());

  void showLoading() {
    emit(ShowLoading());
  }

  void hideLoading() {
    emit(HideLoading());
  }
}
