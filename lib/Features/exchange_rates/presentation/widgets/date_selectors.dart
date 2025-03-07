import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swypex_currency/Features/exchange_rates/presentation/controllers/exchange_rate_controller.dart';
import 'package:swypex_currency/core/widgets/custom_button.dart';

class DateSelectors extends StatelessWidget {
  const DateSelectors({
    super.key,
    required this.exchangeRateController,
    required this.onUpdate,
  });

  final ExchangeRateController exchangeRateController;
  final VoidCallback onUpdate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            text: exchangeRateController.startDate == null
                ? "Start Date"
                : "Start: ${DateFormat('yyyy-MM-dd').format(exchangeRateController.startDate!)}",
            onPressed: () => exchangeRateController.selectDate(
              context,
              true,
              onUpdate, // Trigger state update after date selection
            ),
          ),
        ),
        Expanded(
          child: CustomButton(
            text: exchangeRateController.endDate == null
                ? "End Date"
                : "End: ${DateFormat('yyyy-MM-dd').format(exchangeRateController.endDate!)}",
            onPressed: () => exchangeRateController.selectDate(
              context,
              false,
              onUpdate, // Trigger state update after date selection
            ),
          ),
        ),
      ],
    );
  }
}
