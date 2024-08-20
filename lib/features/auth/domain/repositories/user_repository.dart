import 'package:fakestore/core/network/network_exception/network_exception.dart';
import 'package:fakestore/features/auth/domain/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class UserRepository {
  Future<Either<NetworkException, UserEntity?>> login(
      {required String username, required String password});
  Future<Either<NetworkException, UserEntity?>> getUser();
  Future<Either<NetworkException, bool?>> logout();
}
