import 'package:fakestore/core/mapper/data_mapper.dart';
import 'package:fakestore/features/cart/domain/entities/product_details_quantity_entity.dart';
import 'package:fakestore/features/product_details/domain/entities/product_entity.dart';

import '../../../product_details/data/model/product_model.dart';

class ProductDetailsQuantityModel
    implements DataMapper<ProductDetailsQuantityEntity> {
  final ProductModel? products;
  final int? quantity;

  ProductDetailsQuantityModel({this.products, this.quantity});

  @override
  ProductDetailsQuantityEntity mapToEntity() {
    return ProductDetailsQuantityEntity(
        products: products?.mapToEntity() ?? ProductEntity(),
        quantity: quantity ?? 0);
  }
}
