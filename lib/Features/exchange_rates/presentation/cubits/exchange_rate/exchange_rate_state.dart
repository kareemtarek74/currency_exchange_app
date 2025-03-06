part of 'exchange_rate_cubit.dart';

abstract class ExchangeRateState {}

class ExchangeRateInitial extends ExchangeRateState {}

class ExchangeRateLoading extends ExchangeRateState {}

class ExchangeRateNoData extends ExchangeRateState {}

class ExchangeRateLoaded extends ExchangeRateState {
  final List<ExchangeRate> rates;
  final int currentPage;
  final int totalRatesCount;

  ExchangeRateLoaded({
    required this.rates,
    required this.currentPage,
    required this.totalRatesCount,
  });
}

class ExchangeRateError extends ExchangeRateState {
  final String message;

  ExchangeRateError(this.message);
}
