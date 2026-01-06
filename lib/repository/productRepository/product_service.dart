// import 'package:fakestorefake/model/product_model.dart';
// import 'package:fakestorefake/repository/data_state.dart';
// import 'package:fakestorefake/repository/productRepository/product_repo.dart';

// class ProductService {
//   ProductService(this._productRepo);
//   final ProductInterface _productRepo;
//   Future<List<Product>> fetchAllProducts() async {
//     final response = await _productRepo.fetchAllProducts();
//     switch (response) {
//       case DataSuccess():
//         try {
//           final data = response.data as Map<String, dynamic>;
//           final productList = data['products'] as List;
//           return productList.map((json) => Product.fromJson(json)).toList();
//         } catch (e) {
//           return <Product>[];
//         }
//       case DataError():
//       default:
//         return <Product>[];
//     }
//   }
// }
