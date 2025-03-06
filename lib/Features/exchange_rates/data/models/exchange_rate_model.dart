// this class represents a single exchange rate entry, containing details about the date, source currency, target currency, and the exchange price
class ExchangeRate {
  final String date;
  final String from;
  final String to;
  final double price;

  ExchangeRate({
    required this.date,
    required this.from,
    required this.to,
    required this.price,
  });
// factory constructor: convert JSON to ExchangeRate Object
  factory ExchangeRate.fromJson(
      String date, Map<String, dynamic> json, String from, String to) {
    return ExchangeRate(
      date: date,
      from: from,
      to: to,
      price: json["$from$to"] ?? 0.0, // ensure safe access to the exchange rate
    );
  }
}
