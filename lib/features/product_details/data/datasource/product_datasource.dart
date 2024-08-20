import 'package:fakestore/core/network/dio_client.dart';
import 'package:fakestore/features/product_details/data/model/product_model.dart';

abstract class ProductDatasource {
  Future<List<ProductModel>?> getAllProduct();
  Future<List<ProductModel>?> getProductByCategory(String? category);
}

class ProductDatasourceImpl implements ProductDatasource {
  final DioClient dioClient;

  ProductDatasourceImpl({required this.dioClient});

  @override
  Future<List<ProductModel>?> getAllProduct() async {
    try {
      final response = await dioClient.get('products');
      final listModel = (response.data as List)
          .map<ProductModel>((dataJson) => ProductModel.fromJson(dataJson))
          .toList();
      return listModel;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ProductModel>?> getProductByCategory(String? category) async {
    try {
      final response = await dioClient.get('products/category/$category');
      final listModel = (response.data as List)
          .map<ProductModel>((dataJson) => ProductModel.fromJson(dataJson))
          .toList();
      return listModel;
    } catch (e) {
      rethrow;
    }
  }
}
