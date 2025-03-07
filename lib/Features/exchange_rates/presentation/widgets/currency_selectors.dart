import 'package:flutter/material.dart';
import 'package:swypex_currency/Features/exchange_rates/presentation/controllers/exchange_rate_controller.dart';
import 'package:swypex_currency/core/widgets/custom_drop_down.dart';

class CurrencySelectors extends StatelessWidget {
  const CurrencySelectors({
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
          child: CustomDropdown(
            value: exchangeRateController.fromCurrency,
            items: exchangeRateController.fromCurrencies,
            onChanged: (value) {
              exchangeRateController.fromCurrency = value!;
              onUpdate(); // Update state when selection changes
            },
          ),
        ),
        Expanded(
          child: CustomDropdown(
            value: exchangeRateController.toCurrency,
            items: exchangeRateController.toCurrencies,
            onChanged: (value) {
              exchangeRateController.toCurrency = value!;
              onUpdate(); // Update state when selection changes
            },
          ),
        ),
      ],
    );
  }
}
