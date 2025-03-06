import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swypex_currency/Features/exchange_rates/data/models/exchange_rate_model.dart';
import 'package:swypex_currency/Features/exchange_rates/domain/UseCases/exchange_rate_use_case.dart';
import 'package:swypex_currency/injection_container.dart';

part 'exchange_rate_state.dart';

// cubit responsible for managing exchange rate state that handles: fetching exchange rates from API, implementing pagination, debouncing requests to avoid excessive API calls.
class ExchangeRateCubit extends Cubit<ExchangeRateState> {
  final FetchExchangeRatesUseCase _useCase =
      serviceLocator<FetchExchangeRatesUseCase>();

  List<ExchangeRate> allRates = [];
  int currentPage = 1;
  final int rowsPerPage = 10;
  Timer? debounceTimer; // timer used for debouncing API requests

  ExchangeRateCubit()
      : super(
            ExchangeRateInitial()); // initializes the cubit with an initial state

  int get totalItems => allRates
      .length; // returns the total number of exchange rate records fetched

  // fetches exchange rates with debouncing to prevent excessive API calls, debounce delay: 500ms
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

// moves to the next page if more data is available
  void nextPage() {
    if ((currentPage * rowsPerPage) < allRates.length) {
      currentPage++;
      emitPagedData();
    }
  }

// moves to the previous page if not on the first page
  void previousPage() {
    if (currentPage > 1) {
      currentPage--;
      emitPagedData();
    }
  }

// emits the paginated exchange rates to the ui
  void emitPagedData() {
    final startIndex = (currentPage - 1) * rowsPerPage;
    final pagedData = allRates
        .skip(startIndex)
        .take(rowsPerPage)
        .toList(); // Uses skip and take to fetch only relevant data for the page
    emit(ExchangeRateLoaded(
      rates: pagedData,
      currentPage: currentPage,
      totalRatesCount: allRates.length,
    ));
  }
}
