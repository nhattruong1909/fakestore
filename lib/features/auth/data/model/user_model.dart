import 'package:fakestore/core/mapper/data_mapper.dart';
import 'package:fakestore/features/auth/domain/entities/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel implements DataMapper<UserEntity> {
  @JsonKey(name: 'sub')
  final int? id;
  @JsonKey(name: 'user')
  final String? username;

  UserModel({this.id, this.username});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  @override
  UserEntity mapToEntity() {
    return UserEntity(id: id, username: username);
  }
}
