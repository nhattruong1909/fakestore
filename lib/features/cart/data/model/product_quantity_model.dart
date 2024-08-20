import 'package:fakestore/core/mapper/data_mapper.dart';
import 'package:fakestore/features/cart/domain/entities/product_quantity_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'product_quantity_model.g.dart';

@JsonSerializable()
class ProductQuantityModel implements DataMapper<ProductQuantityEntity?> {
  final int? productId;
  final int? quantity;

  ProductQuantityModel({this.productId, this.quantity});

  factory ProductQuantityModel.fromJson(Map<String, dynamic> json) =>
      _$ProductQuantityModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductQuantityModelToJson(this);

  @override
  ProductQuantityEntity? mapToEntity() {
    return ProductQuantityEntity(
        productId: productId ?? 0, quantity: quantity ?? 0);
  }
}
