// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_bloc.dart';

enum ProductStatus { loading, success, empty, error }

class ProductState extends Equatable {
  const ProductState({
    this.products = const [],
    this.productMap = const {},
    this.allProducts = const [],
    this.tabIndex = 0,
    this.productStatus = ProductStatus.empty,
    this.favoriteIds = const {},
    this.likedIds = const {},
    this.selectedIds = const {},
  });
  final List<Product>? products;
  final Map<String, Product>? productMap;
  final List<Product>? allProducts;
  final int? tabIndex;
  final ProductStatus productStatus;
  final Set<String>? favoriteIds;
  final Set<String>? likedIds;
  final Set<String>? selectedIds;

  @override
  List<Object?> get props => [
    products,
    productMap,
    allProducts,
    tabIndex,
    productStatus,
    favoriteIds,
    likedIds,
    selectedIds,
  ];

  @override
  String toString() =>
      "list length = ${products?.length} tab index = $tabIndex";

  ProductState copyWith({
    List<Product>? products,
    Map<String, Product>? productMap,
    List<Product>? allProducts,
    int? tabIndex,
    ProductStatus? productStatus,
    Set<String>? favoriteIds,
    Set<String>? likedIds,
    Set<String>? selectedIds,
  }) {
    return ProductState(
      products: products ?? this.products,
      productMap: productMap ?? this.productMap,
      allProducts: allProducts ?? this.allProducts,
      tabIndex: tabIndex ?? this.tabIndex,
      productStatus: productStatus ?? this.productStatus,
      favoriteIds: favoriteIds ?? this.favoriteIds,
      likedIds: likedIds ?? this.likedIds,
      selectedIds: selectedIds ?? this.selectedIds,
    );
  }
}
