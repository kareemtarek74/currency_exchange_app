import 'package:flutter/material.dart';
import 'package:swypex_currency/Features/exchange_rates/data/models/exchange_rate_model.dart';
import 'package:swypex_currency/Features/exchange_rates/presentation/widgets/exchange_rate_table.dart';
import 'package:swypex_currency/Features/exchange_rates/presentation/widgets/pagination_controls.dart';

class CurrencyTable extends StatelessWidget {
  final List<ExchangeRate> rates;
  final int currentPage;
  final int totalRatesCount;
  final int rowsPerPage;

  const CurrencyTable({
    super.key,
    required this.rates,
    required this.currentPage,
    required this.totalRatesCount,
    required this.rowsPerPage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .95,
              child: ExchangeRateTable(
                  rates: rates,
                  currentPage: currentPage,
                  rowsPerPage: rowsPerPage),
            ),
          ),
        ),
        const SizedBox(height: 10),
        PaginationControls(
          currentPage: currentPage,
          totalRatesCount: totalRatesCount,
          rowsPerPage: rowsPerPage,
        ),
      ],
    );
  }
}
