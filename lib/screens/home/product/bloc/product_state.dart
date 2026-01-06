part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

final class ProductLoadingState extends ProductState {}

final class ProductLoadedState extends ProductState {
  final List<Product> products;

  const ProductLoadedState(this.products);
}

final class ProductEmptyState extends ProductState {
  final String? message;

  const ProductEmptyState({this.message});
}
