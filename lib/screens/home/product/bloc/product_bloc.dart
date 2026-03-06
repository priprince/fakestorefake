// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc, Emitter;

import 'package:fakestorefake/constants/logs.dart' show logger;
import 'package:fakestorefake/model/product_model.dart' show Product;
import 'package:fakestorefake/repository/productRepository/product_repo.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductInterface _productRepo;
  ProductBloc(this._productRepo) : super(ProductState()) {
    on<FetchProductEvent>(productFetchMethod);
    add(FetchProductEvent());
    on<TabBarChangeEvent>(tabBarChangeMethod);
    on<ProductLikeEvent>(productLikeMethod);
    on<ProductSelectEvent>(productSelectMethod);
    on<ProductFavoriteEvent>(productFavoriteMethod);
  }
  FutureOr<void> tabBarChangeMethod(
    TabBarChangeEvent event,
    Emitter<ProductState> emit,
  ) {
    final index = event.index;
    final filterProducts = filterProductsMethod(state.allProducts ?? [], index);
    emit(state.copyWith(tabIndex: index, products: filterProducts));
  }

  FutureOr<void> productFetchMethod(
    FetchProductEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(productStatus: ProductStatus.loading));
    final response = await _productRepo.fetchAllProducts();
    if (!response.isSuccess) {
      logger.f("empty state emit");
      emit(state.copyWith(productStatus: ProductStatus.empty, products: []));
      return;
    }
    logger.f("success state emit");
    final productBundle = response.data;
    // final copyProducts = response.data;
    logger.i(state.toString());
    if (productBundle!.products.isEmpty == true) {
      emit(state.copyWith(productStatus: ProductStatus.empty));
      return;
    }
    final filterProducts = filterProductsMethod(
      productBundle.products,
      state.tabIndex!,
    );
    emit(
      state.copyWith(
        products: filterProducts,
        allProducts: productBundle.products,
        productMap: productBundle.productMap,
        productStatus: ProductStatus.success,
      ),
    );
  }

  FutureOr<void> productLikeMethod(
    ProductLikeEvent event,
    Emitter<ProductState> emit,
  ) {
    final likedId = event.id;
    final updatedLikedIds = Set<String>.from(state.likedIds ?? {});

    logger.i(updatedLikedIds);
    if (updatedLikedIds.contains(likedId)) {
      updatedLikedIds.remove(likedId);
    } else {
      updatedLikedIds.add(likedId);
    }
    logger.i("like ids after $updatedLikedIds");
    emit(state.copyWith(likedIds: updatedLikedIds));
  }

  FutureOr<void> productSelectMethod(
    ProductSelectEvent event,
    Emitter<ProductState> emit,
  ) async {
    final productId = event.id;
    final selectedIds = Set<String>.from(state.selectedIds ?? {});
    if (selectedIds.contains(productId)) {
      selectedIds.remove(productId);
      emit(state.copyWith(selectedIds: selectedIds));
    } else {
      selectedIds.add(productId);
      emit(state.copyWith(selectedIds: selectedIds));
    }
  }

  FutureOr<void> productFavoriteMethod(
    ProductFavoriteEvent event,
    Emitter<ProductState> emit,
  ) {
    final productId = event.id;
    final favoriteIds = Set<String>.from(state.favoriteIds ?? {});
    if (favoriteIds.contains(productId)) {
      favoriteIds.remove(productId);
      emit(state.copyWith(favoriteIds: favoriteIds));
    } else {
      favoriteIds.add(productId);
      emit(state.copyWith(favoriteIds: favoriteIds));
    }
  }
}

List<Product> filterProductsMethod(List<Product> allProducts, int tabIndex) {
  final index = tabIndex;
  if (index == 0) {
    return allProducts.where((item) => item.price! <= 30).toList();
  }
  return allProducts.where((item) => item.price! > 31).toList();
}

class ProductBundle {
  List<Product> products;
  Map<String, Product> productMap;
  Set<String>? favoriteIds;
  Set<String>? likedIds;
  Set<String>? selectedIds;
  ProductBundle({
    required this.products,
    required this.productMap,
    this.favoriteIds = const {},
    this.likedIds = const {},
    this.selectedIds = const {},
  });
}

class TileModel extends Equatable {
  final Product product;
  final bool isSelected;
  const TileModel({required this.product, required this.isSelected});

  @override
  List<Object?> get props => [product, isSelected];
}
