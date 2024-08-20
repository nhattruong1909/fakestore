import 'package:fakestore/features/cart/domain/entities/product_details_quantity_entity.dart';
import 'package:flutter/material.dart';

class CartRow extends StatelessWidget {
  const CartRow({
    super.key,
    this.product,
  });
  final ProductDetailsQuantityEntity? product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(8)),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                height: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(product?.products?.image ?? ''),
                        fit: BoxFit.contain)),
              )),
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    product?.products?.title ?? '',
                    maxLines: 2,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    product?.products?.category ?? '',
                    style: const TextStyle(fontWeight: FontWeight.w300),
                  ),
                  Text(
                    '${product?.products?.price} \$',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.orange),
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Quantity: ${product?.quantity}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
