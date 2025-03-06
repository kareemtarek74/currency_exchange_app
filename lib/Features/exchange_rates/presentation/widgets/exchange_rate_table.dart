import 'package:flutter/material.dart';
import 'package:swypex_currency/Features/exchange_rates/data/models/exchange_rate_model.dart';
import 'package:swypex_currency/core/utils/app_colors.dart';
import 'package:swypex_currency/core/utils/text_styles.dart';

class ExchangeRateTable extends StatelessWidget {
  final List<ExchangeRate> rates;
  final int currentPage;
  final int rowsPerPage;

  const ExchangeRateTable({
    super.key,
    required this.rates,
    required this.currentPage,
    required this.rowsPerPage,
  });

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: 12,
      headingRowHeight: 28,
      dataRowMinHeight: 20,
      dataRowMaxHeight: 30,
      headingRowColor: WidgetStateColor.resolveWith(
          (states) => AppColors.lightSecondaryColor),
      border: const TableBorder(
        top: BorderSide(color: Colors.black, width: 1.5),
        bottom: BorderSide(color: Colors.black, width: 1.5),
        left: BorderSide(color: Colors.black, width: 1.5),
        right: BorderSide(color: Colors.black, width: 1.5),
        verticalInside: BorderSide(color: Colors.black, width: 1.5),
      ),
      columns: [
        DataColumn(label: Text("Date", style: Styles.styleBold18(context))),
        DataColumn(label: Text("From", style: Styles.styleBold18(context))),
        DataColumn(label: Text("To", style: Styles.styleBold18(context))),
        DataColumn(label: Text("Price", style: Styles.styleBold18(context))),
      ],
      rows: List.generate(rates.length, (index) {
        final rate = rates[index];
        final globalIndex = ((currentPage - 1) * rowsPerPage) + index;

        return DataRow(
          color: WidgetStateColor.resolveWith(
            (states) =>
                globalIndex.isEven ? AppColors.secondaryColor : Colors.white,
          ),
          cells: [
            DataCell(Text(rate.date, style: Styles.styleBold14(context))),
            DataCell(Text(rate.from, style: Styles.styleBold14(context))),
            DataCell(Text(rate.to, style: Styles.styleBold14(context))),
            DataCell(Text(rate.price.toStringAsFixed(3),
                style: Styles.styleBold14(context))),
          ],
        );
      }),
    );
  }
}
