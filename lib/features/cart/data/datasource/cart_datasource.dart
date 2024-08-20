import 'package:fakestore/core/network/dio_client.dart';
import 'package:fakestore/features/product_details/data/model/product_model.dart';

import '../../../utils/model/cart_request_model.dart';
import '../../domain/entities/product_quantity_entity.dart';
import '../model/cart_model.dart';

abstract class CartDatasource {
  Future<List<CartModel>?> getCartByUserId(int id);
  Future<List<ProductModel>?> getProductsById(
      List<ProductQuantityEntity>? products);
  Future<CartModel?> addNewCart(CartRequestModel? model);
  Future<CartModel?> updateCart(CartRequestModel? model);
}

class CartDatasourceImpl implements CartDatasource {
  final DioClient dioClient;
  CartDatasourceImpl({required this.dioClient});

  @override
  Future<List<CartModel>?> getCartByUserId(int id) async {
    final response = await dioClient.get('carts/user/$id');
    var list_model = (response.data as List)
        .map<CartModel>((dataJson) => CartModel.fromJson(dataJson))
        .toList();
    return list_model;
  }

  @override
  Future<List<ProductModel>?> getProductsById(
      List<ProductQuantityEntity>? products) async {
    List<ProductModel>? list_model = [];
    for (final product in products!) {
      final response = await dioClient.get('products/${product.productId}');
      final model = ProductModel.fromJson(response.data);
      list_model.add(model);
    }
    return list_model;
  }

  @override
  Future<CartModel?> addNewCart(CartRequestModel? model) async {
    var model_json = model?.toJson();
    model_json?.remove('id');
    final response = await dioClient.post('carts', data: model_json);
    final cart_model = CartModel.fromJson(response.data);
    return cart_model;
  }

  @override
  Future<CartModel?> updateCart(CartRequestModel? model) async {
    var model_json = model?.toJson();
    String? id = model_json?['id'].toString();
    model_json?.remove('id');
    final response = await dioClient.patch('carts/$id', data: model?.toJson());
    final cart_model = CartModel.fromJson(response.data);
    return cart_model;
  }
}
