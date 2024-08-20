import 'package:dio/dio.dart';
import 'package:fakestore/core/network/dio_client.dart';
import 'package:fakestore/features/auth/data/model/token_model.dart';

abstract class UserDatasource {
  Future<TokenModel?> login(String username, String password);
}

class UserDatasourceImpl implements UserDatasource {
  final DioClient dioClient;

  UserDatasourceImpl({required this.dioClient});

  @override
  Future<TokenModel?> login(String username, String password) async {
    try {
      final Response response = await dioClient.post('auth/login',
          data: {'username': username, 'password': password});
      if (response.statusCode == 200) {
        final token = TokenModel.fromJson(response.data);
        return token;
      } else if (response.statusCode == 401) {
        throw Exception('Incorret user or password!');
      } else {
        throw Exception('Login Failed');
      }
    } catch (e) {
      rethrow;
    }
  }
}
