part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchProductEvent extends ProductEvent {}

class TabBarChangeEvent extends ProductEvent {
  final int index;
  const TabBarChangeEvent(this.index);
}

class ProductLikeEvent extends ProductEvent {
  final String id;
  const ProductLikeEvent(this.id);
}

class ProductSelectEvent extends ProductEvent {
  final String id;
  const ProductSelectEvent(this.id);
}

class ProductFavoriteEvent extends ProductEvent {
  final String id;
  const ProductFavoriteEvent(this.id);
}
