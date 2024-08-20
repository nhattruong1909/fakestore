import 'package:json_annotation/json_annotation.dart';
part 'cart_request_model.g.dart';

@JsonSerializable()
class CartRequestModel {
  final int? id;
  final int? userId;
  final String? date;
  final List<Map<String, dynamic>>? products;

  Map<String, dynamic> toJson() => _$CartRequestModelToJson(this);

  CartRequestModel({this.id = 0, this.userId, this.date, this.products});
}
