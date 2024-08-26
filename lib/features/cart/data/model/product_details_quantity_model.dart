import 'package:fakestore/core/mapper/data_mapper.dart';
import 'package:fakestore/features/cart/domain/entities/product_details_quantity_entity.dart';
import 'package:fakestore/features/product_details/domain/entities/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../product_details/data/model/product_model.dart';

part 'product_details_quantity_model.g.dart';

@JsonSerializable()
class ProductDetailsQuantityModel
    implements DataMapper<ProductDetailsQuantityEntity> {
  final ProductModel? products;
  final int? quantity;

  ProductDetailsQuantityModel({this.products, this.quantity});

  factory ProductDetailsQuantityModel.fromJson(Map<String, dynamic> json) =>
  _$ProductDetailsQuantityModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailsQuantityModelToJson(this);

  @override
  ProductDetailsQuantityEntity mapToEntity() {
    return ProductDetailsQuantityEntity(
        products: products?.mapToEntity() ?? ProductEntity(),
        quantity: quantity ?? 0);
  }
}
