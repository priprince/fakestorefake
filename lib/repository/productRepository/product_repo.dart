import 'package:fakestorefake/graphql/dio_service.dart';
import 'package:fakestorefake/graphql/graphql_queries.dart';
import 'package:fakestorefake/model/product_model.dart' show Product;
import 'package:fakestorefake/repository/data_state.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../screens/home/product/bloc/product_bloc.dart' show ProductBundle;

abstract class ProductInterface {
  Future<Result<ProductBundle>> fetchAllProducts();
}

class ProductRepo implements ProductInterface {
  ProductRepo(this._graphqlDioService);
  final GraphqlDioService _graphqlDioService;
  @override
  Future<Result<ProductBundle>> fetchAllProducts() async {
    try {
      final response = await _graphqlDioService.execute(() {
        return _graphqlDioService.query(GraphqlQueries.getAllProducts());
      });
      switch (response) {
        case DataSuccess():
          final data = (response.data as Map<String, dynamic>);
          // logger.i(data);
          // final productModel = ProductModel.fromJson(data);
          final productsRaw = data['data']['products'] as List;
          final products = <Product>[];
          final productMap = <String, Product>{};
          for (final json in productsRaw) {
            final product = Product.fromJson(json);
            products.add(product);
            productMap[product.id!] = product;
          }
          return Result.success(
            ProductBundle(products: products, productMap: productMap),
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
