import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swypex_currency/app.dart';
import 'package:swypex_currency/bloc_observer.dart';
import 'package:swypex_currency/core/models/security_issue.dart';
import 'package:swypex_currency/core/utils/security_utils.dart';
import 'package:swypex_currency/core/widgets/blocked_screen.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
  Bloc.observer = AppBlocObserver();

  List<SecurityIssue> securityIssues =
      await SecurityUtils.checkDeviceSecurity();

  if (securityIssues.isNotEmpty) {
    runApp(SecurityWarningScreen(securityIssues: securityIssues));
  } else {
    runApp(const SwypexCurrency());
  }
}
