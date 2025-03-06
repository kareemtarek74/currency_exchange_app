import 'package:dio/dio.dart';

class RequestData {
  Map<String, dynamic>? headers;
  Map<String, dynamic>? params;
  String? contentType;

  RequestData(
      {this.headers, this.contentType = Headers.jsonContentType, this.params});
  
  @override
  String toString() =>
      'RequestData(headers: $headers, params: $params, contentType: $contentType)';
}
