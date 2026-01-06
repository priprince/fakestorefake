// import 'package:graphql_flutter/graphql_flutter.dart' show OperationException;

import 'package:graphql_flutter/graphql_flutter.dart';

abstract class DataState<T> {
  final T? data;
  final T? error;
  const DataState({this.data, this.error});
}

class DataSuccess<T> extends DataState<T> {
  DataSuccess(T data) : super(data: data);
}

class DataError<T> extends DataState<T> {
  DataError(T error, T? data) : super(error: error, data: data);
}

class Result<T> {
  final T? data;
  final String? message;
  final dynamic error;

  const Result.success(this.data, {this.message}) : error = null;
  Result.failure(this.error)
    : data = null,
      message = error is OperationException
          ? error.graphqlErrors.first.message
          : error.toString();

  bool get isSuccess => data != null;
}
