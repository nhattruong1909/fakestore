import 'package:equatable/equatable.dart';
import 'package:fakestore/features/cart/domain/entities/product_quantity_entity.dart';

class CartEntity extends Equatable {
  final int? id;
  final int? userId;
  final DateTime? date;
  final List<ProductQuantityEntity>? products;

  CartEntity({this.id, this.userId, this.date, this.products});

  @override
  // TODO: implement props
  List<Object?> get props => <Object?>[id, userId, date, products];
}
