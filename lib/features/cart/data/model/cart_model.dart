import 'package:fakestore/core/mapper/data_mapper.dart';
import 'package:fakestore/features/cart/data/model/product_quantity_model.dart';
import 'package:fakestore/features/cart/domain/entities/cart_entity.dart';
import 'package:fakestore/features/cart/domain/entities/product_quantity_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cart_model.g.dart';

@JsonSerializable()
class CartModel implements DataMapper<CartEntity> {
  final int? id;
  final int? userId;
  final DateTime? date;
  final List<ProductQuantityModel>? products;

  CartModel({this.id, this.userId, this.date, this.products});

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartModelToJson(this);

  @override
  CartEntity mapToEntity() {
    return CartEntity(
        id: id ?? 0,
        userId: userId ?? 0,
        date: date,
        products: products
                ?.map<ProductQuantityEntity>((product) =>
                    product.mapToEntity() ?? ProductQuantityEntity())
                .toList() ??
            []);
  }
}
