import 'package:flutter/material.dart';
import 'package:swypex_currency/Features/exchange_rates/data/models/exchange_rate_model.dart';
import 'package:swypex_currency/Features/exchange_rates/presentation/widgets/exchange_rate_table.dart';
import 'package:swypex_currency/Features/exchange_rates/presentation/widgets/pagination_controls.dart';

// a widget that displays the currency exchange table along with pagination controls
class CurrencyTable extends StatelessWidget {
  final List<ExchangeRate> rates; // list of exchange rate data to display
  final int currentPage; //The current page index for pagination
  final int
      totalRatesCount; //the total number of exchange rate entries available
  final int rowsPerPage; //the number of rows displayed per page

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
        // displays the exchange rate table with scrollable horizontal view
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
        // displays pagination controls to navigate between pages
        PaginationControls(
          currentPage: currentPage,
          totalRatesCount: totalRatesCount,
          rowsPerPage: rowsPerPage,
        ),
      ],
    );
  }
}
