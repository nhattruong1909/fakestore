import 'package:fakestore/core/commondomain/usecase/usecase.dart';
import 'package:fakestore/core/network/network_exception/network_exception.dart';
import 'package:fakestore/features/auth/domain/entities/user_entity.dart';
import 'package:fakestore/features/auth/domain/repositories/user_repository.dart';
import 'package:fpdart/src/either.dart';

class GetUser implements Usecase<UserEntity?, NoParams> {
  final UserRepository userRepository;

  GetUser({required this.userRepository});

  @override
  Future<Either<NetworkException, UserEntity?>> call(NoParams? param) async {
    return await userRepository.getUser();
  }
}
