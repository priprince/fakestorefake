import 'package:fakestorefake/constants/logs.dart' show logger;
import 'package:fakestorefake/graphql/dio_service.dart';
import 'package:fakestorefake/graphql/graphql_queries.dart';
import 'package:fakestorefake/model/product_model.dart'
    show Product, ProductModel;
import 'package:fakestorefake/repository/data_state.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class ProductInterface {
  Future<Result<List<Product>>> fetchAllProducts();
}

class ProductRepo implements ProductInterface {
  ProductRepo(this._graphqlDioService);
  final GraphqlDioService _graphqlDioService;
  @override
  Future<Result<List<Product>>> fetchAllProducts() async {
    try {
      final response = await _graphqlDioService.execute(() {
        return _graphqlDioService.query(GraphqlQueries.getAllProducts());
      });
      switch (response) {
        case DataSuccess():
          final data = (response.data as Map<String, dynamic>);
          // logger.i(data);
          // final productModel = ProductModel.fromJson(data);
          final products = data['data']['products'] as List;
          return Result.success(
            products.map((product) => Product.fromJson(product)).toList(),
          );
        case DataError():
        default:
          return Result.failure(response.error);
      }
    } on OperationException catch (f) {
      return Result.failure(f);
    } catch (e) {
      return Result.failure(e);
    }
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
