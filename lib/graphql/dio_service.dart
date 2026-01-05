import 'package:dio/dio.dart' show Dio, Response, DioException;
import 'package:fakestorefake/dependency/get_it.dart' show url;
import 'package:graphql_flutter/graphql_flutter.dart'
    show OperationException, GraphQLError;

import '../repository/data_state.dart' show DataState, DataSuccess, DataError;

typedef GraphqlExecutor = Future<Response> Function();

class GraphqlDioService {
  GraphqlDioService(this._dio);
  final Dio _dio;

  Future<DataState> execute(GraphqlExecutor call) async {
    try {
      final response = await call();
      final data = response.data;

      if (response.statusCode == 200 && data?['errors'] == null) {
        return DataSuccess(data);
      }

      return DataError(
        OperationException(
          graphqlErrors:
              (data?['errors'] as List?)
                  ?.map((e) => GraphQLError(message: e['message']))
                  .toList() ??
              [],
        ),
        null,
      );
    } on DioException catch (e) {
      return DataError(
        OperationException(
          graphqlErrors: [GraphQLError(message: e.message ?? 'Network error')],
        ),
        null,
      );
    } catch (e) {
      return DataError(
        OperationException(
          graphqlErrors: [GraphQLError(message: e.toString())],
        ),
        null,
      );
    }
  }

  Future<Response> query(
    String query, {
    Map<String, dynamic>? variables,
  }) async {
    final response = await _dio.post(
      url,
      data: {'query': query, 'variables': variables ?? {}},
    );
    return response;
  }

  Future<Response> mutate(
    String mutation, {
    Map<String, dynamic>? variables,
  }) async {
    final response = await _dio.post(
      url,
      data: {'query': mutation, 'variables': variables ?? {}},
    );

    return response;
  }
}
