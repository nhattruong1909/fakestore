import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int? id;
  final String? username;

  UserEntity({this.id, this.username});

  @override
  List<Object?> get props => <Object?>[id, username];
}
