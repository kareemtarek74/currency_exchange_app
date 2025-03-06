import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swypex_currency/Features/exchange_rates/presentation/controllers/exchange_rate_controller.dart';
import 'package:swypex_currency/core/utils/app_colors.dart';
import 'package:swypex_currency/core/widgets/custom_button.dart';
import 'package:swypex_currency/core/widgets/custom_drop_down.dart';

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
                Row(
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
                ),
                const SizedBox(height: 20),
                // Row for selecting the currencies
                Row(
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
                ),
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
