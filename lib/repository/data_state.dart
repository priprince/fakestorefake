// import 'package:graphql_flutter/graphql_flutter.dart' show OperationException;

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

  const Result.success(this.data, {this.message});
  const Result.failure(this.message) : data = null;

  bool get isSuccess => data != null;
}
