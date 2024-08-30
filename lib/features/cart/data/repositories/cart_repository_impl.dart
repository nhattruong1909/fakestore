import 'package:dio/dio.dart';
import 'package:fakestore/core/network/network_exception/network_exception.dart';
import 'package:fakestore/features/cart/data/datasource/cart_datasource.dart';
import 'package:fakestore/features/cart/data/datasource/cart_local_datasource.dart';
import 'package:fakestore/features/cart/data/model/product_details_quantity_model.dart';
import 'package:fakestore/features/cart/domain/entities/cart_entity.dart';
import 'package:fakestore/features/cart/domain/entities/product_quantity_entity.dart';
import 'package:fakestore/features/cart/domain/repositories/cart_repository.dart';
import 'package:fakestore/features/product_details/data/model/product_model.dart';

import 'package:fpdart/src/either.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/model/cart_request_model.dart';
import '../../domain/entities/product_details_quantity_entity.dart';

class CartRepositoryImpl implements CartRepository {
  final CartDatasource cartDatasource;
  final CartLocalDatasource cartLocalDatasource;

  CartRepositoryImpl({required this.cartLocalDatasource,required this.cartDatasource});

  @override
  Future<Either<NetworkException, List<CartEntity>?>> getCartByUserId(
      int? userId) async {
    try {
      if(await _isTimeExpiredNoSetTime()){
      final list_model = await cartDatasource.getCartByUserId(userId!);
      if (list_model!=null && list_model.isNotEmpty){
        await cartLocalDatasource.insertCartLocal(list_model[0]);
      } 
      List<CartEntity>? list_entity =
          list_model?.map<CartEntity>((cart) => cart.mapToEntity()).toList() ??
              [];
      return right(list_entity);}
      else{
        final model = await cartLocalDatasource.getCart();
        List<CartEntity>? list_entity = [];
        if(model != null) {
          list_entity.add(model.mapToEntity());
        }
        return right(list_entity);
      }
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
      bool isTimeExpired = await _isTimeExpired();
      // bool isTimeExpired = true;
      final List<ProductModel>?  list_model_products;
      final List<ProductDetailsQuantityModel>?  list_model;
      if(isTimeExpired){
      list_model_products =
          await cartDatasource.getProductsById(products);
      list_model = list_model_products
          ?.map((model) => ProductDetailsQuantityModel(
              products: model,   
              quantity: products
                  ?.firstWhere((element) => element.productId == model.id)
                  .quantity))
          .toList();
      await cartLocalDatasource.insertOrUpdateProductsCart(list_model);
      }else{
        list_model = await cartLocalDatasource.readLocalCart();
      }
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
      _clearPreviousTime();
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
      _clearPreviousTime();
      return right(cart_model?.mapToEntity());
    } on DioException catch (e) {
      return left(NetworkException.fromDioError(e));
    } catch (e) {
      return left(NetworkException(e.toString()));
    }
  }

  Future<bool> _isTimeExpired() async{
    DateTime? currentTime = DateTime.now();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? prevTime = preferences.getString('prevTime');
    if (prevTime == null || prevTime.isEmpty){
      preferences.setString('prevTime', currentTime.toIso8601String());
      return true;
    }
    else{
      Duration diff = currentTime.difference(DateTime.parse(prevTime));
      if (diff.inMinutes > 5){
        preferences.setString('prevTime', currentTime.toIso8601String());
        return true;
      } else{
        return false;
      }
    }
  }

  Future<bool> _isTimeExpiredNoSetTime() async{
    DateTime? currentTime = DateTime.now();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? prevTime = preferences.getString('prevTime');
    if (prevTime == null || prevTime.isEmpty){
      return true;
    }
    else{
      Duration diff = currentTime.difference(DateTime.parse(prevTime));
      if (diff.inMinutes > 5){
        preferences.setString('prevTime', currentTime.toIso8601String());
        return true;
      } else{
        return false;
      }
    }
  }

  Future<void> _clearPreviousTime() async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    await preferences.remove('prevTime');
  }
}
