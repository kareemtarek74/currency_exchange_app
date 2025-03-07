import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swypex_currency/Features/exchange_rates/presentation/controllers/exchange_rate_controller.dart';
import 'package:swypex_currency/Features/exchange_rates/presentation/cubits/exchange_rate/exchange_rate_cubit.dart';
import 'package:swypex_currency/Features/exchange_rates/presentation/widgets/currency_table.dart';
import 'package:swypex_currency/Features/exchange_rates/presentation/widgets/empty_state_widget.dart';
import 'package:swypex_currency/Features/exchange_rates/presentation/widgets/exchange_rate_filters.dart';
import 'package:swypex_currency/Features/exchange_rates/presentation/widgets/shimmer_loading.dart';
import 'package:swypex_currency/core/utils/app_strings.dart';

// The widget of the main body handles state changes and UI rendering.
class CurrencyExchangeScreenBody extends StatefulWidget {
  const CurrencyExchangeScreenBody({super.key});

  @override
  CurrencyExchangeScreenBodyState createState() =>
      CurrencyExchangeScreenBodyState();
}

class CurrencyExchangeScreenBodyState
    extends State<CurrencyExchangeScreenBody> {
  static const double topPadding = 64.0;
  static const double filterSpacing = 20.0;
  static const int rowsPerPage = 10;

  final ExchangeRateController exchangeRateController =
      ExchangeRateController(); // Controller to manage date selection and currency dropdowns.

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: topPadding),
          // Widget for selecting dates and currencies
          ExchangeRateFilters(
            exchangeRateController: exchangeRateController,
            onUpdate: () {
              setState(() {}); // Update UI after user interaction
            },
          ),
          const SizedBox(height: filterSpacing),
          // Displays data based on the state of the ExchangeRateCubit
          Expanded(
            child: BlocBuilder<ExchangeRateCubit, ExchangeRateState>(
              builder: (context, state) {
                return switch (state) {
                  ExchangeRateLoading() => const ShimmerLoadingWidget(),
                  ExchangeRateLoaded() => CurrencyTable(
                      rates: state.rates,
                      currentPage: state.currentPage,
                      totalRatesCount: state.totalRatesCount,
                      rowsPerPage: rowsPerPage,
                    ),
                  ExchangeRateNoData() => const Center(
                      child: Text(
                        AppStrings.emptyDataError,
                        style: TextStyle(color: Colors.red, fontSize: 16),
                      ),
                    ),
                  _ => EmptyStateWidget(
                      onPickDate: () => exchangeRateController.selectDate(
                        context,
                        true,
                        () => setState(() {}),
                      ),
                    ),
                };
              },
            ),
          ),
        ],
      ),
    );
  }
}
