import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:swypex_currency/Features/exchange_rates/data/data_sources/exchange_rate_remote_data_source.dart';
import 'package:swypex_currency/Features/exchange_rates/data/models/exchange_rate_model.dart';
import 'package:swypex_currency/Features/exchange_rates/domain/Repos/exchange_rate_repo.dart';
import 'package:swypex_currency/core/Api/failure.dart';
import 'package:swypex_currency/core/Api/failure_handler.dart';
import 'package:swypex_currency/injection_container.dart';

class ExchangeRateRepositoryImpl implements ExchangeRateRepository {
  final ExchangeRateRemoteDataSource _remoteDataSource =
      serviceLocator<ExchangeRateRemoteDataSource>();
  final _failureHandler = serviceLocator<FailureHandler>();
  @override
  Future<Either<Failure, List<ExchangeRate>>> getExchangeRates(
      String startDate, String endDate, String from, String to) async {
    try {
      final remoteData = await _remoteDataSource.fetchExchangeRates(
          startDate, endDate, from, to);
      return Right(remoteData);
    } on DioException catch (e) {
      final failure = _failureHandler.getFailureType(e);
      return Left(failure);
    }
  }
}
