import 'package:fakestore/core/commondomain/usecase/usecase.dart';
import 'package:fakestore/core/network/network_exception/network_exception.dart';
import 'package:fakestore/features/cart/domain/entities/product_quantity_entity.dart';
import 'package:fakestore/features/cart/domain/repositories/cart_repository.dart';
import 'package:fpdart/src/either.dart';

import '../entities/product_details_quantity_entity.dart';

class GetProductsByIds
    implements
        Usecase<List<ProductDetailsQuantityEntity>?,
            List<ProductQuantityEntity>> {
  final CartRepository cartRepository;

  GetProductsByIds({required this.cartRepository});

  @override
  Future<Either<NetworkException, List<ProductDetailsQuantityEntity>?>> call(
      List<ProductQuantityEntity>? products) async {
    return await cartRepository.getProductsByIds(products);
  }
}
