import 'package:dio/dio.dart';
import 'package:fakestore/core/network/network_exception/network_exception.dart';
import 'package:fakestore/features/product_details/data/datasource/product_datasource.dart';
import 'package:fakestore/features/product_details/domain/entities/product_entity.dart';
import 'package:fakestore/features/product_details/domain/repositories/product_details_repository.dart';
import 'package:fpdart/src/either.dart';
import 'package:fpdart/fpdart.dart';

class ProductDetailsRepositoryImpl implements ProductDetailsRepositories {
  final ProductDatasource productDatasource;
  ProductDetailsRepositoryImpl({required this.productDatasource});

  @override
  Future<Either<NetworkException, List<ProductEntity>?>> getAllProduct() async {
    try {
      final listModel = await productDatasource.getAllProduct();
      final listEntities =
          listModel?.map((model) => model.mapToEntity()).toList();
      return right(listEntities);
    } on DioException catch (e) {
      return left(NetworkException.fromDioError(e));
    } on Exception catch (e) {
      return left(NetworkException(e.toString()));
    }
  }

  @override
  Future<Either<NetworkException, List<ProductEntity>?>> getProductByCategory(
      String? category) async {
    try {
      if (category == null) {
        return left(NetworkException('Null category!'));
      }
      final listModel = await productDatasource.getProductByCategory(category);
      final listEntities =
          listModel?.map((model) => model.mapToEntity()).toList();
      return right(listEntities);
    } on DioException catch (e) {
      return left(NetworkException.fromDioError(e));
    } on Exception catch (e) {
      return left(NetworkException(e.toString()));
    }
  }
}
