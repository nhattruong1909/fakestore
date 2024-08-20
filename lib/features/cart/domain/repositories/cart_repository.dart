import 'package:fakestore/core/network/network_exception/network_exception.dart';
import 'package:fakestore/features/cart/domain/entities/product_details_quantity_entity.dart';
import 'package:fakestore/features/utils/model/cart_request_model.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/cart_entity.dart';
import '../entities/product_quantity_entity.dart';

abstract class CartRepository {
  Future<Either<NetworkException, List<CartEntity>?>> getCartByUserId(
      int? userId);
  Future<Either<NetworkException, List<ProductDetailsQuantityEntity>?>>
      getProductsByIds(List<ProductQuantityEntity>? products);
  Future<Either<NetworkException, CartEntity?>> addNewCart(
      CartRequestModel? cart);
  Future<Either<NetworkException, CartEntity?>> updateCart(
      CartRequestModel? cart);
}
