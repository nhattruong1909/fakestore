import 'package:fakestore/core/mapper/data_mapper.dart';
import 'package:fakestore/features/auth/domain/entities/token_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'token_model.g.dart';

@JsonSerializable()
class TokenModel implements DataMapper<TokenEntity> {
  final String? token;

  TokenModel({this.token});

  factory TokenModel.fromJson(Map<String, dynamic> json) =>
      _$TokenModelFromJson(json);

  @override
  TokenEntity mapToEntity() {
    return TokenEntity(token: token);
  }
}
