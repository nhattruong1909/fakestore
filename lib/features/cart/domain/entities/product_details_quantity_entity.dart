import 'package:equatable/equatable.dart';

import '../../../product_details/domain/entities/product_entity.dart';

class ProductDetailsQuantityEntity extends Equatable {
  final ProductEntity? products;
  final int? quantity;

  ProductDetailsQuantityEntity({this.products, this.quantity});

  @override
  List<Object?> get props => <Object?>[products, quantity];
}
