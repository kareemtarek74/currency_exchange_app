import 'package:flutter/material.dart';
import 'package:swypex_currency/Features/exchange_rates/presentation/controllers/exchange_rate_controller.dart';
import 'package:swypex_currency/Features/exchange_rates/presentation/widgets/currency_selectors.dart';
import 'package:swypex_currency/Features/exchange_rates/presentation/widgets/date_selectors.dart';
import 'package:swypex_currency/core/utils/app_colors.dart';
import 'package:swypex_currency/core/widgets/custom_button.dart';

// It includes date pickers and currency selection dropdowns.
class ExchangeRateFilters extends StatelessWidget {
  final ExchangeRateController exchangeRateController;
  final VoidCallback onUpdate;

  const ExchangeRateFilters({
    super.key,
    required this.exchangeRateController,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DateSelectors(
                    exchangeRateController: exchangeRateController,
                    onUpdate: onUpdate),
                const SizedBox(height: 20),
                // Row for selecting the currencies
                CurrencySelectors(
                    exchangeRateController: exchangeRateController,
                    onUpdate: onUpdate),
              ],
            ),
          ),
          const SizedBox(width: 10),
          // Submit button to fetch exchange rates
          SizedBox(
            width: MediaQuery.sizeOf(context).width * .27,
            height: 36,
            child: CustomButton(
              text: "Submit",
              onPressed: () =>
                  exchangeRateController.fetchExchangeRates(context),
              backgroundColor: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
