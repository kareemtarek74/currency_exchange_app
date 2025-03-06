import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swypex_currency/Features/exchange_rates/data/models/exchange_rate_model.dart';
import 'package:swypex_currency/Features/exchange_rates/domain/UseCases/exchange_rate_use_case.dart';
import 'package:swypex_currency/injection_container.dart';

part 'exchange_rate_state.dart';

class ExchangeRateCubit extends Cubit<ExchangeRateState> {
  final FetchExchangeRatesUseCase _useCase =
      serviceLocator<FetchExchangeRatesUseCase>();

  List<ExchangeRate> allRates = [];
  int currentPage = 1;
  final int rowsPerPage = 10;
  Timer? debounceTimer;

  ExchangeRateCubit() : super(ExchangeRateInitial());

  int get totalItems => allRates.length;

  void loadExchangeRates(
      String startDate, String endDate, String from, String to) {
    debounceTimer?.cancel();

    debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      emit(ExchangeRateLoading());

      final eitherResult = await _useCase(startDate, endDate, from, to);

      eitherResult.fold(
        (failure) => emit(ExchangeRateError(failure.msg ?? "Unknown error")),
        (rates) {
          if (rates.isEmpty) {
            emit(ExchangeRateNoData());
          } else {
            allRates = rates;
            currentPage = 1;
            emitPagedData();
          }
        },
      );
    });
  }

  void nextPage() {
    if ((currentPage * rowsPerPage) < allRates.length) {
      currentPage++;
      emitPagedData();
    }
  }

  void previousPage() {
    if (currentPage > 1) {
      currentPage--;
      emitPagedData();
    }
  }

  void emitPagedData() {
    final startIndex = (currentPage - 1) * rowsPerPage;
    final pagedData = allRates.skip(startIndex).take(rowsPerPage).toList();
    emit(ExchangeRateLoaded(
      rates: pagedData,
      currentPage: currentPage,
      totalRatesCount: allRates.length,
    ));
  }
}
