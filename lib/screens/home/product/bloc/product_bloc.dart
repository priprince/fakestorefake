import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:fakestorefake/constants/logs.dart' show logger;
import 'package:fakestorefake/model/product_model.dart' show Product;
import 'package:fakestorefake/repository/productRepository/product_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc, Emitter;

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepo _productRepo;
  ProductBloc(this._productRepo) : super(ProductInitial()) {
    on<FetchProductEvent>(productFetchMethod);
    add(FetchProductEvent());
  }

  FutureOr<void> productFetchMethod(
    FetchProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoadingState());
    final response = await _productRepo.fetchAllProducts();
    if (response.isSuccess) {
      logger.f("success state emit");
      final products = response.data;
      emit(ProductLoadedState(products!));
      return;
    }
    logger.f("empty state emit");
    emit(ProductEmptyState(message: response.message));
  }
}
