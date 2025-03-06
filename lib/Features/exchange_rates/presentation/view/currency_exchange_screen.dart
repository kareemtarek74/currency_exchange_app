import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swypex_currency/Features/exchange_rates/presentation/cubits/exchange_rate/exchange_rate_cubit.dart';
import 'package:swypex_currency/Features/exchange_rates/presentation/widgets/currency_exchange_screen_body.dart';
import 'package:swypex_currency/injection_container.dart';

/// This is the main screen that provides the Bloc for managing exchange rate state.
class CurrencyExchangeScreen extends StatelessWidget {
  const CurrencyExchangeScreen({super.key});
  static const String routeName = '/change_currency_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        // Provides an instance of ExchangeRateCubit using dependency injection.
        create: (context) => serviceLocator<ExchangeRateCubit>(),
        child: const SafeArea(child: CurrencyExchangeScreenBody()),
      ),
    );
  }
}
