// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details_quantity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailsQuantityModel _$ProductDetailsQuantityModelFromJson(
        Map<String, dynamic> json) =>
    ProductDetailsQuantityModel(
      products: json['products'] == null
          ? null
          : ProductModel.fromJson(json['products'] as Map<String, dynamic>),
      quantity: (json['quantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductDetailsQuantityModelToJson(
        ProductDetailsQuantityModel instance) =>
    <String, dynamic>{
      'products': instance.products,
      'quantity': instance.quantity,
    };
