import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:swypex_currency/Features/exchange_rates/presentation/cubits/exchange_rate/exchange_rate_cubit.dart';

class ExchangeRateController {
  DateTime? startDate;
  DateTime? endDate;
  String fromCurrency = "USD";
  String toCurrency = "EGP";

  final List<String> fromCurrencies = ["USD", "EGP"];
  final List<String> toCurrencies = ["EGP"];
  void selectDate(
      BuildContext context, bool isStartDate, VoidCallback updateState) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 1)),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: const ColorScheme.light(
              primary: Colors.grey,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey,
              ),
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      if (isStartDate) {
        startDate = picked;
      } else {
        endDate = picked;
      }
      updateState();
    }
  }

  void fetchExchangeRates(BuildContext context) {
    if (startDate == null || endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select start and end dates")),
      );
      return;
    }

    context.read<ExchangeRateCubit>().loadExchangeRates(
          DateFormat('yyyy-MM-dd').format(startDate!),
          DateFormat('yyyy-MM-dd').format(endDate!),
          fromCurrency,
          toCurrency,
        );
  }
}
