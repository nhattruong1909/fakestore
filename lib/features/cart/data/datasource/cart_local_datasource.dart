import 'package:fakestore/features/cart/data/model/product_details_quantity_model.dart';
import 'package:fakestore/features/cart/domain/entities/product_details_quantity_entity.dart';
import 'package:hive/hive.dart';

abstract class CartLocalDatasource{
  Future<void> insertOrUpdateCart(List<ProductDetailsQuantityModel?> list_product);
  Future<List<ProductDetailsQuantityEntity?>> readLocalCart ();
}

class CartLocalDatasourceImpl implements CartLocalDatasource{
  final Box box;

  CartLocalDatasourceImpl({required this.box});
  
  
  @override
  Future<void> insertOrUpdateCart(List<ProductDetailsQuantityModel?> list_product) async {
    box.clear();
    List<Map<String, dynamic>?> list_product_json = list_product.map((product)=>product?.toJson()).toList();
    for(final product in list_product_json){
    await box.put(product!["products"]["id"],product);}

  }
  
  @override
  Future<List<ProductDetailsQuantityEntity?>> readLocalCart() {
    // TODO: implement readLocalCart
    throw UnimplementedError();
  }

  
}