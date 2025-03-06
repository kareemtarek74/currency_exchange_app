import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:swypex_currency/Features/exchange_rates/presentation/view/currency_exchange_screen.dart';
import 'package:swypex_currency/core/helper_function/on_generate_function.dart';

class SwypexCurrency extends StatelessWidget {
  const SwypexCurrency({super.key});
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: onGenerateRoute,
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: CurrencyExchangeScreen.routeName,
      ),
    );
  }
}
