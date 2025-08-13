import 'package:equatable/equatable.dart';
import 'package:pokexplorer/core/common/errors/exceptions.dart';

abstract class Failure extends Equatable {
  Failure({required this.message, required this.statusCode})
      : assert(
          statusCode is int || statusCode is String,
          'statusCode must be either an int or a String not a ${statusCode.runtimeType}',
        );

  final String message;
  final dynamic statusCode;

  String get errorMessage => '$statusCode ${statusCode is String ? '' : ' Error'}: $message';

  @override
  List<Object?> get props => [message, statusCode];
}

class ApiFailure extends Failure {
  ApiFailure({required super.message, required super.statusCode});

  ApiFailure.fromException(ApiException apiException) : this(message: apiException.message, statusCode: apiException.statusCode);
}

class CacheFailure extends Failure {
  CacheFailure({required super.message, required super.statusCode});
}

class NetworkFailure extends Failure {
  NetworkFailure({required super.message, required super.statusCode});
}
