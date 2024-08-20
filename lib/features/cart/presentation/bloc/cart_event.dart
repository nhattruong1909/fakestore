part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class GetCartsEvent extends CartEvent {
  final int? id;
  const GetCartsEvent({this.id});
}

class GetProductsCartEvent extends CartEvent {
  final List<ProductQuantityEntity>? products;
  const GetProductsCartEvent({this.products});
}

class AddCartEvent extends CartEvent {
  final int? productId;
  final String? date;
  final int? userId;

  AddCartEvent({this.date, this.productId, this.userId});
}

class UpdateCartEvent extends CartEvent {
  final int? productId;
  final CartEntity? cart;
  final String? date;

  UpdateCartEvent({this.date, this.productId, this.cart});
}
