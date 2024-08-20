// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fakestore/core/commondomain/usecase/usecase.dart';
import 'package:fakestore/core/network/network_exception/network_exception.dart';
import 'package:fakestore/features/product_details/domain/entities/product_entity.dart';
import 'package:fakestore/features/product_details/domain/repositories/product_details_repository.dart';
import 'package:fpdart/src/either.dart';

class GetProductByCategory implements Usecase<List<ProductEntity>?, String> {
  ProductDetailsRepositories productDetailsRepositories;
  GetProductByCategory({
    required this.productDetailsRepositories,
  });

  @override
  Future<Either<NetworkException, List<ProductEntity>?>> call(
      String? category) async {
    return await productDetailsRepositories.getProductByCategory(category);
  }
}
