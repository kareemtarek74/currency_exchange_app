import 'package:dio/dio.dart';
import 'package:swypex_currency/core/Api/api_consumer.dart';
import 'package:swypex_currency/core/Api/http_service.dart';
import 'package:swypex_currency/core/Api/request_data.dart';

class ApiConsumerImpl implements ApiConsumer {
  final HttpService httpService;

  ApiConsumerImpl({required this.httpService});

  @override
/*************  ✨ Codeium Command ⭐  *************/
  /// Sends a GET request to the specified [path].
  ///
  /// Optionally, [requestData] can be provided to include additional
  /// headers, query parameters, or other request configurations.
  ///
  /// Returns a [Future] that resolves to a [Response] object containing
  /// the server's response to the GET request.

  /// ****  117dc7b9-3199-4c02-91f2-5641a8890a9a  ******
  Future<Response> get(String path, {RequestData? requestData}) async {
    return await httpService.get(path, requestData: requestData);
  }

  @override
  Future<Response> post(String path,
      {Object? body, RequestData? requestData}) async {
    return await httpService.post(path, body!, requestData: requestData);
  }

  @override
  Future<Response> put(String path,
      {Object? body, RequestData? requestData}) async {
    return await httpService.put(path,
        requestBody: body, requestData: requestData);
  }

  @override
  Future<Response> delete(String path, {RequestData? requestData}) async {
    return await httpService.delete(path, requestData: requestData);
  }
}
