import 'package:fakestorefake/graphql/dio_service.dart';
import 'package:fakestorefake/graphql/graphql_queries.dart';
import 'package:fakestorefake/repository/data_state.dart';

abstract class ProductInterface {
  Future<DataState> fetchAllProducts();
}

class ProductRepo implements ProductInterface {
  ProductRepo(this._graphqlDioService);
  final GraphqlDioService _graphqlDioService;
  @override
  Future<DataState> fetchAllProducts() async {
    final response = await _graphqlDioService.execute(() {
      return _graphqlDioService.query(GraphqlQueries.getAllProducts());
    });
    return response;
  }
  // Future<DataState> fetchAllProducts() async {
  //   try {
  //     final response = await _graphqlDioService.query(
  //       GraphqlQueries.getAllProducts(),
  //     );
  //     final data = response.data;

  //     if (data != null && data?['errors'] == null) {
  //       return DataSuccess(response.data);
  //     } else {
  //       return DataError(OperationException(graphqlErrors: data.map), []);
  //     }
  //   } catch (e) {
  //     if (e is DioException) {
  //       return DataError(e.message, []);
  //     }
  //     return DataError(
  //       OperationException(
  //         graphqlErrors: [GraphQLError(message: e.toString())],
  //       ),
  //       [],
  //     );
  //   }
  // }
}
