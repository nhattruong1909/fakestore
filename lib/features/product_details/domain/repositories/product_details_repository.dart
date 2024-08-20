import 'package:fakestore/core/network/network_exception/network_exception.dart';
import 'package:fakestore/features/product_details/domain/entities/product_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class ProductDetailsRepositories {
  Future<Either<NetworkException, List<ProductEntity>?>> getAllProduct();
  Future<Either<NetworkException, List<ProductEntity>?>> getProductByCategory(
      String? category);
}
