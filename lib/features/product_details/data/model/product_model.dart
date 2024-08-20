import 'package:fakestore/core/mapper/data_mapper.dart';
import 'package:fakestore/features/product_details/domain/entities/product_entity.dart';
import 'package:fakestore/features/product_details/domain/entities/rating_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import 'rating_model.dart';
part 'product_model.g.dart';

@JsonSerializable()
class ProductModel implements DataMapper<ProductEntity> {
  final int? id;
  final String? title;
  final double? price;
  final String? description;
  final String? category;
  final String? image;
  final RatingModel? rating;

  ProductModel(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.category,
      this.image,
      this.rating});

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  @override
  ProductEntity mapToEntity() {
    return ProductEntity(
        id: id ?? 0,
        title: title ?? '',
        price: price ?? 0.0,
        description: description ?? '',
        category: category ?? '',
        image: image ?? '',
        rating: rating?.mapToEntity() ?? RatingEntity());
  }
}
