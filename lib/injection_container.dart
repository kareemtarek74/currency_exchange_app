import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:swypex_currency/Features/exchange_rates/data/Repos/exchange_rate_repo_impl.dart';
import 'package:swypex_currency/Features/exchange_rates/data/data_sources/exchange_rate_remote_data_source.dart';
import 'package:swypex_currency/Features/exchange_rates/domain/Repos/exchange_rate_repo.dart';
import 'package:swypex_currency/Features/exchange_rates/domain/UseCases/exchange_rate_use_case.dart';
import 'package:swypex_currency/Features/exchange_rates/presentation/cubits/exchange_rate/exchange_rate_cubit.dart';
import 'package:swypex_currency/core/Api/end_points.dart';
import 'package:swypex_currency/core/Api/failure_handler.dart';
import 'package:swypex_currency/core/Api/http_service.dart';
import 'package:swypex_currency/core/Api/http_service_helper.dart';
import 'package:swypex_currency/core/Api/http_service_impl.dart';

final sl = GetIt.instance;
final serviceLocator = sl;

BaseOptions _dioOptions() {
  return BaseOptions(
    baseUrl: EndPoints.baseUrl, // Base URL
    connectTimeout: const Duration(seconds: 50),
    receiveTimeout: const Duration(seconds: 50),
    sendTimeout: const Duration(seconds: 50),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    validateStatus: (status) {
      return status != null && status <= 500;
    },
  );
}

Future<void> init() async {
  //! ############################### External ###############################
  sl.registerLazySingleton(() => LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true));

  if (!serviceLocator.isRegistered<Dio>()) {
    serviceLocator.registerLazySingleton<Dio>(() => Dio(_dioOptions()));
  }
  HttpServiceHelper.setupInterceptors();

  //! ############################### Service ###############################
  serviceLocator.registerLazySingleton<FailureHandler>(() => FailureHandler());
  serviceLocator.registerLazySingleton<HttpService>(() => HttpServiceImpl());

  //! ################################ Datasources #################################
  serviceLocator.registerLazySingleton<ExchangeRateRemoteDataSource>(
      () => ExchangeRateRemoteDataSourceImpl());
  //! ################################# Repository #################################
  serviceLocator.registerLazySingleton<ExchangeRateRepository>(
      () => ExchangeRateRepositoryImpl());
  //! ################################# Usecases #################################
  serviceLocator.registerLazySingleton(() => FetchExchangeRatesUseCase());

  //! ############################### Bloc Or Cubit ###############################
  serviceLocator.registerFactory(() => ExchangeRateCubit());
}
