import 'package:equatable/equatable.dart';

class ProductQuantityEntity extends Equatable {
  final int? productId;
  final int? quantity;

  ProductQuantityEntity({this.productId, this.quantity});

  @override
  // TODO: implement props
  List<Object?> get props => <Object?>[productId, quantity];
}
