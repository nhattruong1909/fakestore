// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fakestore/core/commondomain/usecase/usecase.dart';
import 'package:fakestore/core/network/network_exception/network_exception.dart';
import 'package:fakestore/features/product_details/domain/entities/product_entity.dart';
import 'package:fakestore/features/product_details/domain/repositories/product_details_repository.dart';
import 'package:fpdart/src/either.dart';

class GetAllProduct implements Usecase<List<ProductEntity>?, NoParams> {
  ProductDetailsRepositories productDetailsRepositories;
  GetAllProduct({
    required this.productDetailsRepositories,
  });

  @override
  Future<Either<NetworkException, List<ProductEntity>?>> call(
      NoParams? param) async {
    return await productDetailsRepositories.getAllProduct();
  }
}
