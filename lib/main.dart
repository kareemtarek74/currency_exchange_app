import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swypex_currency/app.dart';
import 'package:swypex_currency/bloc_observer.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
  Bloc.observer = AppBlocObserver();
  runApp(const SwypexCurrency());
}
