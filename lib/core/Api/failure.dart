abstract class Failure {
  final String? msg;
  final Object? data;

  Failure({this.msg, this.data});
}

class InternalServerErrorFailure extends Failure {
  InternalServerErrorFailure({super.msg, super.data});
}

class BadRequestFailure extends Failure {
  BadRequestFailure({super.msg, super.data});
}

class UnauthorizedFailure extends Failure {
  UnauthorizedFailure({super.msg, super.data});
}

class NotFoundFailure extends Failure {
  NotFoundFailure({super.msg, super.data});
}

class MethodNotAllowedFailure extends Failure {
  MethodNotAllowedFailure({super.msg, super.data});
}

class ConnectionTimeoutFailure extends Failure {
  ConnectionTimeoutFailure({super.msg, super.data});
}

class NoInternetConnectionFailure extends Failure {
  NoInternetConnectionFailure({super.msg, super.data});
}

class HttpFailure extends Failure {
  HttpFailure({super.msg, super.data});
}

class RequestCanceledFailure extends Failure {
  RequestCanceledFailure({super.msg, super.data});
}

class UnknownFailure extends Failure {
  UnknownFailure({super.msg, super.data});
}

class LogoutFailure extends Failure {
  LogoutFailure({super.msg, super.data});
}

class CustomFailure extends Failure {
  CustomFailure({super.msg, Object? data}) : super(data: data.toString());
}
