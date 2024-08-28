import 'package:dio/dio.dart';
import 'package:fakestore/core/network/network_exception/network_exception.dart';
import 'package:fakestore/features/auth/data/datasource/user_datasource.dart';
import 'package:fakestore/features/auth/data/model/user_model.dart';
import 'package:fakestore/features/auth/domain/entities/user_entity.dart';
import 'package:fakestore/features/auth/domain/repositories/user_repository.dart';
import 'package:fakestore/features/cart/data/datasource/cart_local_datasource.dart';
import 'package:fpdart/src/either.dart';
import 'package:jwt_decode_full/jwt_decode_full.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDatasource userDatasource;
  final CartLocalDatasource cartLocalDatasource;

  UserRepositoryImpl({required this.cartLocalDatasource,required this.userDatasource});

  @override
  Future<Either<NetworkException, UserEntity?>> login(
      {required String username, required String password}) async {
    try {
      final model = await userDatasource.login(username, password);
      if (model == null) {
        return left(NetworkException('Login Failed!'));
      }
      final userModel = UserModel.fromJson(_getPayload(model.token!));
      _saveToken(model.token!);
      return right(userModel.mapToEntity());
    } on DioException catch (e) {
      return left(NetworkException.fromDioError(e));
    } on Exception catch (e) {
      return left(NetworkException(e.toString()));
    }
  }

  Map<String, dynamic> _getPayload(String token) {
    final decodedPayload = jwtDecode(token).payload;
    return decodedPayload;
  }

  Future<void> _saveToken(
    String token,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Token', token);
    prefs.setString('Username', _getPayload(token)["user"]);
    prefs.setInt('UserId', _getPayload(token)["sub"]);
  }

  @override
  Future<Either<NetworkException, UserEntity?>> getUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("Token");
      int? id = prefs.getInt("UserId");
      String? username = prefs.getString("Username");
      if (token == null || id == null || username == null) {
        return left(NetworkException('Not Logged In'));
      } else {
        return right(UserEntity(id: id, username: username));
      }
    } catch (e) {
      return left(NetworkException(e.toString()));
    }
  }

  @override
  Future<Either<NetworkException, bool?>> logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove("Token");
      prefs.remove("UserId");
      prefs.remove("Username");
      await cartLocalDatasource.clearCart();
      prefs.remove("prevTime");
      return right(true);
    } catch (e) {
      return left(NetworkException(e.toString()));
    }
  }
}
