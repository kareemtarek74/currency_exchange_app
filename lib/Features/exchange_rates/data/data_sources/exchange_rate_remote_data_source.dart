import 'package:swypex_currency/Features/exchange_rates/data/models/exchange_rate_model.dart';
import 'package:swypex_currency/core/Api/end_points.dart';
import 'package:swypex_currency/core/Api/http_service.dart';
import 'package:swypex_currency/injection_container.dart';

//fetches exchange rates from the API for a given date range and currency pair
abstract class ExchangeRateRemoteDataSource {
  Future<List<ExchangeRate>> fetchExchangeRates(
      String startDate, String endDate, String from, String to);
}

// implementation of ExchangeRateRemoteDataSource
class ExchangeRateRemoteDataSourceImpl implements ExchangeRateRemoteDataSource {
  final HttpService _httpHelper = serviceLocator<HttpService>();

  @override
  Future<List<ExchangeRate>> fetchExchangeRates(
      String startDate, String endDate, String from, String to) async {
    final url = '${EndPoints.baseUrl}${EndPoints.exchangeRates}'
        '?access_key=feb6443aa59c23611b5c7759d0423785'
        '&start_date=$startDate&end_date=$endDate&currencies=$from,$to';
    // making a GET request to fetch exchange rate data
    final response = await _httpHelper.get(url);

// extracting quotes from the API response
    final quotes = response.data["quotes"] as Map<String, dynamic>?;

    if (quotes == null || quotes.isEmpty) {
      return []; // returning an empty list if no data is found
    }
// mapping the API response to a list of ExchangeRate objects
    return quotes.entries
        .map((entry) => ExchangeRate.fromJson(entry.key, entry.value, from, to))
        .toList();
  }
}
