// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_quantity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductQuantityModel _$ProductQuantityModelFromJson(
        Map<String, dynamic> json) =>
    ProductQuantityModel(
      productId: (json['productId'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductQuantityModelToJson(
        ProductQuantityModel instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'quantity': instance.quantity,
    };
