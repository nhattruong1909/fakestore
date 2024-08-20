// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fakestore/core/commondomain/usecase/usecase.dart';
import 'package:fakestore/core/network/network_exception/network_exception.dart';
import 'package:fakestore/features/auth/domain/repositories/user_repository.dart';
import 'package:fpdart/src/either.dart';

class Logout implements Usecase<bool?, NoParams> {
  UserRepository userRepository;
  Logout({
    required this.userRepository,
  });

  @override
  Future<Either<NetworkException, bool?>> call(NoParams? param) async {
    return await userRepository.logout();
  }
}
