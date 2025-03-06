import 'package:dio/dio.dart';
import 'package:swypex_currency/core/Api/request_data.dart';

abstract class ApiConsumer {
  Future<Response> get(String path, {RequestData? requestData});
  Future<Response> post(String path, {Object? body, RequestData? requestData});
  Future<Response> put(String path, {Object? body, RequestData? requestData});
  Future<Response> delete(String path, {RequestData? requestData});
}
