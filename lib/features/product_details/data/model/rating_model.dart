import 'package:fakestore/core/mapper/data_mapper.dart';
import 'package:fakestore/features/product_details/domain/entities/rating_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rating_model.g.dart';

@JsonSerializable()
class RatingModel implements DataMapper<RatingEntity> {
  final double? rate;
  final int? count;

  RatingModel({this.rate, this.count});

  factory RatingModel.fromJson(Map<String, dynamic> json) =>
      _$RatingModelFromJson(json);

  Map<String, dynamic> toJson() => _$RatingModelToJson(this);

  @override
  RatingEntity mapToEntity() {
    return RatingEntity(rate: rate ?? 0.0, count: count ?? 0);
  }
}
