import 'package:dartz/dartz.dart';
import 'package:swypex_currency/Features/exchange_rates/data/models/exchange_rate_model.dart';
import 'package:swypex_currency/core/Api/failure.dart';

abstract class ExchangeRateRepository {
  Future<Either<Failure, List<ExchangeRate>>> getExchangeRates(
      String startDate, String endDate, String from, String to);
}
