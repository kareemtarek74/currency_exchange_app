import 'package:dartz/dartz.dart';
import 'package:swypex_currency/Features/exchange_rates/data/models/exchange_rate_model.dart';
import 'package:swypex_currency/Features/exchange_rates/domain/Repos/exchange_rate_repo.dart';
import 'package:swypex_currency/core/Api/failure.dart';
import 'package:swypex_currency/injection_container.dart';

class FetchExchangeRatesUseCase {
  final ExchangeRateRepository _repo = serviceLocator<ExchangeRateRepository>();

  Future<Either<Failure, List<ExchangeRate>>> call(
      String startDate, String endDate, String from, String to) async {
    return await _repo.getExchangeRates(startDate, endDate, from, to);
  }
}
