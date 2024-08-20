import 'package:fakestore/core/commondomain/usecase/usecase.dart';
import 'package:fakestore/core/network/network_exception/network_exception.dart';
import 'package:fakestore/features/cart/domain/entities/cart_entity.dart';
import 'package:fakestore/features/cart/domain/repositories/cart_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetCartByUserId implements Usecase<List<CartEntity>?, int> {
  final CartRepository cartRepository;

  GetCartByUserId({required this.cartRepository});

  @override
  Future<Either<NetworkException, List<CartEntity>?>> call(int? userId) async {
    return await cartRepository.getCartByUserId(userId);
  }
}
