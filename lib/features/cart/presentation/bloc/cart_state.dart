part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

final class CartInitial extends CartState {
  const CartInitial();
}

class CartLoadingState extends CartState {
  const CartLoadingState();
}

class CartLoadedState extends CartState {
  final List<CartEntity>? carts;
  const CartLoadedState({this.carts});

  @override
  List<Object?> get props => [carts];
}

class CartLoadingFailedState extends CartState {
  final String? message;
  const CartLoadingFailedState({this.message});

  @override
  List<Object?> get props => [message];
}

class ProductLoadedState extends CartState {
  final List<ProductDetailsQuantityEntity>? products;
  const ProductLoadedState({this.products});
  @override
  List<Object?> get props => [products];
}

class ProductLoadingFailedState extends CartState {
  final String? message;
  const ProductLoadingFailedState({this.message});
  @override
  List<Object?> get props => [message];
}

// class ErrorCartState extends CartState {
//   final String? message;

//   ErrorCartState({this.message});

//   @override
//   // TODO: implement props
//   List<Object?> get props => [message];
// }
