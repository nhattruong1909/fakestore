import 'package:fakestore/features/cart/data/datasource/local_database.dart';
import 'package:fakestore/features/cart/data/model/product_details_quantity_model.dart';


abstract class CartLocalDatasource{
  Future<void> insertOrUpdateCart(List<ProductDetailsQuantityModel>? list_product);
  Future<List<ProductDetailsQuantityModel>?> readLocalCart ();
  Future<void> clearCart();
}

class CartLocalDatasourceImpl implements CartLocalDatasource{
  final LocalDatabase localDatabase;

  CartLocalDatasourceImpl({required this.localDatabase});
  
  
  @override
  Future<void> insertOrUpdateCart(List<ProductDetailsQuantityModel>? list_product) async {
    List<Map<String, dynamic>>? list_product_json = list_product?.map((product)=>product.toJson()).toList();
    if (list_product_json != null &&  list_product_json.isNotEmpty){
      await localDatabase.clear();
    
    await localDatabase.add(list_product_json);}
    await localDatabase.close();
  }
  
  @override
  Future<List<ProductDetailsQuantityModel>?> readLocalCart()  async {
    var list_json_product = await localDatabase.getAllValues();
    var list_model_products = list_json_product.map((product)=> ProductDetailsQuantityModel.fromJson(product)).toList();
    await localDatabase.close();
    return list_model_products;
  }
  
  @override
  Future<void> clearCart() async{
    await localDatabase.clear();
  }


    
}