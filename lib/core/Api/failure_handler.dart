import 'package:dio/dio.dart';
import 'failure.dart';

class FailureHandler {
  Failure getFailureType(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.cancel:
        return RequestCanceledFailure(msg: 'requestWasCancelled');
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.connectionTimeout:
        return ConnectionTimeoutFailure(msg: 'requestTimeout');
      case DioExceptionType.badResponse:
      case DioExceptionType.unknown:
        return _handleStatusCodeResponse(dioException.response);
      case DioExceptionType.connectionError:
      case DioExceptionType.badCertificate:
        return NoInternetConnectionFailure(
          msg: 'noInternetConnection',
          data: dioException.response?.data,
        );
    }
  }

  Failure _handleStatusCodeResponse(Response? response) {
    if (response == null) {
      return UnknownFailure(msg: 'genericError');
    } else {
      switch (response.statusCode) {
        case 400:
          final message = _extractMessage(response.data);
          return BadRequestFailure(
            msg: message ?? 'badRequest',
            data: response.data,
          );
        case 404:
          return NotFoundFailure(msg: 'notFound', data: response.data);
        case 500:
          return InternalServerErrorFailure(
            msg: 'internalServerError',
            data: response.data,
          );
        default:
          return UnknownFailure(
            msg: _extractMessage(response.data) ?? 'genericError',
            data: response.data,
          );
      }
    }
  }

  String? _extractMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      if (data.containsKey('errors') && data['errors'] is List) {
        final errors = data['errors'] as List;
        if (errors.isNotEmpty) {
          return errors.first.toString();
        }
      }
      if (data.containsKey('message')) {
        return data['message'] as String?;
      }
    }
    return null;
  }
}
