// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fakestore/core/commondomain/usecase/usecase.dart';
import 'package:fakestore/core/network/network_exception/network_exception.dart';
import 'package:fakestore/features/cart/domain/entities/cart_entity.dart';
import 'package:fakestore/features/cart/domain/repositories/cart_repository.dart';
import 'package:fpdart/src/either.dart';

import '../../../utils/model/cart_request_model.dart';

class UpdateCart implements Usecase<CartEntity?, CartRequestModel> {
  CartRepository cartRepository;
  UpdateCart({
    required this.cartRepository,
  });

  @override
  Future<Either<NetworkException, CartEntity?>> call(
      CartRequestModel? cart) async {
    return await cartRepository.updateCart(cart);
  }
}
