import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:swypex_currency/Features/exchange_rates/data/data_sources/exchange_rate_remote_data_source.dart';
import 'package:swypex_currency/Features/exchange_rates/data/models/exchange_rate_model.dart';
import 'package:swypex_currency/Features/exchange_rates/domain/Repos/exchange_rate_repo.dart';
import 'package:swypex_currency/core/Api/failure.dart';
import 'package:swypex_currency/core/Api/failure_handler.dart';
import 'package:swypex_currency/injection_container.dart';

// implementation of the ExchangeRateRepository that is responsible for handling data retrieval from the remote data source and managing error handling using a failure handler.
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
      // if a DioException occurs, it is processed using _failureHandler
      final failure = _failureHandler.getFailureType(e);
      return Left(failure);
    }
  }
}
