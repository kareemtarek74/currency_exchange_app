import 'package:swypex_currency/Features/exchange_rates/data/models/exchange_rate_model.dart';
import 'package:swypex_currency/core/Api/end_points.dart';
import 'package:swypex_currency/core/Api/http_service.dart';
import 'package:swypex_currency/injection_container.dart';

abstract class ExchangeRateRemoteDataSource {
  Future<List<ExchangeRate>> fetchExchangeRates(
      String startDate, String endDate, String from, String to);
}

class ExchangeRateRemoteDataSourceImpl implements ExchangeRateRemoteDataSource {
  final HttpService _httpHelper = serviceLocator<HttpService>();

  @override
  Future<List<ExchangeRate>> fetchExchangeRates(
      String startDate, String endDate, String from, String to) async {
    final url = '${EndPoints.baseUrl}${EndPoints.exchangeRates}'
        '?access_key=d2f3fa262383ed6d0492efffad20d7df'
        '&start_date=$startDate&end_date=$endDate&currencies=$from,$to';
    final response = await _httpHelper.get(url);

    final quotes = response.data["quotes"] as Map<String, dynamic>?;

    if (quotes == null || quotes.isEmpty) {
      return [];
    }

    return quotes.entries
        .map((entry) => ExchangeRate.fromJson(entry.key, entry.value, from, to))
        .toList();
  }
}
