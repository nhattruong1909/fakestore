part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

final class ProductInitialState extends ProductState {
  const ProductInitialState();
}

final class ProductLoadingState extends ProductState {
  const ProductLoadingState();
}

class ProductLoadedState extends ProductState {
  final List<ProductEntity>? listProduct;

  const ProductLoadedState(this.listProduct);

  @override
  List<Object?> get props => [listProduct];
}

class ProductErrorState extends ProductState {
  final String? message;

  const ProductErrorState({this.message});

  @override
  List<Object?> get props => [message];
}
