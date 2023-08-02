import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:ipacking_app/src/feature/home/data/datasources/home_remote_data_source.dart';
import 'package:ipacking_app/src/feature/home/data/repositories/home_repository_impl.dart';
import 'package:ipacking_app/src/feature/home/domain/repositories/home_repository.dart';
import 'package:ipacking_app/src/feature/home/domain/usecases/get_lane_usecase.dart';
import 'package:ipacking_app/src/feature/home/domain/usecases/get_system_config.dart';
import 'package:ipacking_app/src/feature/home/presentation/bloc/home_bloc.dart';
import 'package:ipacking_app/src/feature/login/data/datasources/auth_local_data_source.dart';
import 'package:ipacking_app/src/feature/login/data/datasources/auth_remote_data_source.dart';
import 'package:ipacking_app/src/feature/login/domain/repositories/auth_repository.dart';
import 'package:ipacking_app/src/feature/login/domain/usecases/check_auth.dart';
import 'package:ipacking_app/src/feature/login/domain/usecases/login_with_email.dart';
import 'package:ipacking_app/src/feature/login/domain/usecases/logout.dart';
import 'package:ipacking_app/src/feature/login/presentation/bloc/login_bloc.dart';
import 'package:ipacking_app/src/feature/scan_qr/data/datasources/scan_qr_remote_data_source.dart';
import 'package:ipacking_app/src/feature/scan_qr/data/repositories/scan_qr_repository_impl.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/repositories/scan_qr_repository.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/usecases/create_card_by_id.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/usecases/get_complete_info_by_card_number.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/usecases/get_packing_vehice_by_card_number.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/usecases/payment_transaction_usecase.dart';
import 'package:ipacking_app/src/feature/scan_qr/domain/usecases/upload_card_event_image.dart';
import 'package:ipacking_app/src/feature/scan_qr/presentation/bloc/scan_qr_bloc.dart';
import 'package:ipacking_app/src/shared/blocs_app/authentication.dart';
import 'package:ipacking_app/src/shared/blocs_app/loading_cubit/loading_cubit.dart';
import 'package:ipacking_app/src/shared/network/network_info.dart';
import 'package:ipacking_app/src/shared/services/dio_manager.dart';
import 'package:ipacking_app/src/shared/services/dio_upload_service.dart';
import 'package:ipacking_app/src/shared/services/local_store_service.dart';
import 'package:ipacking_app/src/shared/services/rest_api_service.dart';

import 'src/feature/login/data/repositories/auth_repository_impl.dart';
import 'src/feature/scan_qr/domain/usecases/update_card_by_id.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  _configureBlocs();
  _configureUseCases();
  _configureRepositories();
  _configureDataSources();
  _configureCores();
}

void _configureBlocs() {
  getIt.registerLazySingleton(() => LoadingCubit());
  getIt.registerLazySingleton(
      () => AuthenticationBloc(getIt(), getIt(), getIt(), getIt()));
  getIt.registerFactory(() => LoginBloc(getIt(), getIt()));
  getIt.registerFactory(() => HomeBloc(getIt(), getIt(), getIt()));
  getIt.registerFactory(() => ScanQRBloc(
      getIt(), getIt(), getIt(), getIt(), getIt(), getIt(), getIt(), getIt()));
}

void _configureUseCases() {
  getIt.registerLazySingleton(() => LoginWithEmail(getIt()));
  getIt.registerLazySingleton(() => LogOut(getIt()));
  getIt.registerLazySingleton(() => CheckAuth(getIt()));
  getIt.registerLazySingleton(() => GetCompleteInfoByCardNumber(getIt()));
  getIt.registerLazySingleton(() => GetPackingVehiceByCardNumber(getIt()));
  getIt.registerLazySingleton(() => UpdateCardById(getIt()));
  getIt.registerLazySingleton(() => CreateCardById(getIt()));
  getIt.registerLazySingleton(() => UploadCardEventImage(getIt()));
  getIt.registerLazySingleton(() => GetSystemConfigUseCase(getIt()));
  getIt.registerLazySingleton(() => PaymentTransactionUsecase(getIt()));
  getIt.registerLazySingleton(() => GetLaneUseCase(getIt()));
}

void _configureRepositories() {
  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getIt(), getIt()));
  getIt.registerLazySingleton<ScanQRRepository>(
      () => ScanQRRepositoryImpl(getIt()));
  getIt
      .registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(getIt()));
}

void _configureDataSources() {
  getIt.registerLazySingleton(() => AuthLocalDataSource(getIt()));
  getIt.registerLazySingleton(() => AuthRemoteDataSource(getIt(), getIt()));
  getIt.registerLazySingleton(() => ScanQRRemoteDataSource(getIt(), getIt()));
  getIt.registerLazySingleton(() => HomeRemoteDataSource(getIt(), getIt()));
}

void _configureCores() {
  getIt.registerLazySingleton<RestClient>(() {
    return RestClient(getIt<DioManager>().dio);
  });
  getIt.registerLazySingleton(() => DioManager(getIt(), getIt()));

  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));

  getIt.registerFactory(() => Connectivity());

  getIt.registerLazySingleton(() => LocalStorageService());

  getIt.registerLazySingleton(() => DioUploadService(getIt()));
}
