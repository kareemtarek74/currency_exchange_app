import 'package:flutter/material.dart';
import 'package:swypex_currency/Features/exchange_rates/presentation/view/currency_exchange_screen.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    default:
      return MaterialPageRoute(
          builder: (context) => const CurrencyExchangeScreen());
  }
}
