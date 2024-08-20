import 'package:fakestore/core/commondomain/usecase/usecase.dart';
import 'package:fakestore/core/network/network_exception/network_exception.dart';
import 'package:fakestore/features/auth/domain/entities/user_entity.dart';
import 'package:fakestore/features/auth/domain/repositories/user_repository.dart';
import 'package:fakestore/features/utils/model/user_request_model.dart';
import 'package:fpdart/src/either.dart';
import 'package:fpdart/fpdart.dart';

class Login implements Usecase<UserEntity?, UserRequestModel> {
  final UserRepository userRepository;

  Login({required this.userRepository});

  @override
  Future<Either<NetworkException, UserEntity?>> call(
      UserRequestModel? user) async {
    return await userRepository.login(
        username: user!.username, password: user.password);
  }
}
