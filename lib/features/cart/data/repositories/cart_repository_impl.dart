import 'package:dio/dio.dart';
import 'package:fakestore/core/network/network_exception/network_exception.dart';
import 'package:fakestore/features/cart/data/datasource/cart_datasource.dart';
import 'package:fakestore/features/cart/data/model/product_details_quantity_model.dart';
import 'package:fakestore/features/cart/domain/entities/cart_entity.dart';
import 'package:fakestore/features/cart/domain/entities/product_quantity_entity.dart';
import 'package:fakestore/features/cart/domain/repositories/cart_repository.dart';

import 'package:fpdart/src/either.dart';

import '../../../utils/model/cart_request_model.dart';
import '../../domain/entities/product_details_quantity_entity.dart';

class CartRepositoryImpl implements CartRepository {
  final CartDatasource cartDatasource;

  CartRepositoryImpl({required this.cartDatasource});

  @override
  Future<Either<NetworkException, List<CartEntity>?>> getCartByUserId(
      int? userId) async {
    try {
      final list_model = await cartDatasource.getCartByUserId(userId!);
      List<CartEntity>? list_entity =
          list_model?.map<CartEntity>((cart) => cart.mapToEntity()).toList() ??
              [];
      return right(list_entity);
    } on DioException catch (e) {
      return left(NetworkException.fromDioError(e));
    } catch (e) {
      return left(NetworkException(e.toString()));
    }
  }

  @override
  Future<Either<NetworkException, List<ProductDetailsQuantityEntity>?>>
      getProductsByIds(List<ProductQuantityEntity>? products) async {
    try {
      final list_model_products =
          await cartDatasource.getProductsById(products);
      final list_model = list_model_products
          ?.map((model) => ProductDetailsQuantityModel(
              products: model,
              quantity: products
                  ?.firstWhere((element) => element.productId == model.id)
                  .quantity))
          .toList();
      List<ProductDetailsQuantityEntity>? list_entity = list_model
              ?.map<ProductDetailsQuantityEntity>(
                  (product) => product.mapToEntity())
              .toList() ??
          [];
      return right(list_entity);
    } on DioException catch (e) {
      return left(NetworkException.fromDioError(e));
    } catch (e) {
      return left(NetworkException(e.toString()));
    }
  }

  @override
  Future<Either<NetworkException, CartEntity?>> addNewCart(
      CartRequestModel? cart) async {
    try {
      final cart_model = await cartDatasource.addNewCart(cart);
      return right(cart_model?.mapToEntity());
    } on DioException catch (e) {
      return left(NetworkException.fromDioError(e));
    } catch (e) {
      return left(NetworkException(e.toString()));
    }
  }

  @override
  Future<Either<NetworkException, CartEntity?>> updateCart(
      CartRequestModel? cart) async {
    try {
      final cart_model = await cartDatasource.updateCart(cart);
      return right(cart_model?.mapToEntity());
    } on DioException catch (e) {
      return left(NetworkException.fromDioError(e));
    } catch (e) {
      return left(NetworkException(e.toString()));
    }
  }
}
