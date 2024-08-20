import 'package:fakestore/features/product_details/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ProductView extends StatelessWidget {
  const ProductView({super.key, required this.productEntity});

  final ProductEntity productEntity;

  @override
  Widget build(BuildContext context) {
    String _count = productEntity.rating?.count.toString() ?? '0';
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Fashion',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(5),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(productEntity.image ?? ''))),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      productEntity.title ?? '',
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(productEntity.category ?? '',
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w300)),
                        Row(
                          children: [
                            const Icon(Icons.star,
                                color: Color.fromARGB(255, 238, 79, 5)),
                            Text(productEntity.rating?.rate.toString() ?? '',
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.black)),
                            Text('($_count reviews)')
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text('${productEntity.price} \$',
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange)),
                  ),
                  Text(productEntity.description ?? '',
                      style:
                          const TextStyle(fontSize: 15, color: Colors.black)),
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {
                        Modular.to.pushNamed('/add-cart',
                            arguments: productEntity.id);
                      },
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 5, 75, 204)),
                    ),
                  )
                ],
              ),
            )));
  }
}
