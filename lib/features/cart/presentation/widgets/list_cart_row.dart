import 'package:fakestore/features/cart/domain/entities/cart_entity.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/product_quantity_entity.dart';
import '../bloc/cart_bloc.dart';

class ListCartRow extends StatefulWidget {
  const ListCartRow({super.key, this.cart});
  final CartEntity? cart;
  @override
  State<ListCartRow> createState() => _ListCartRowState();
}

class _ListCartRowState extends State<ListCartRow> {
  CartBloc cartBloc = Modular.get<CartBloc>();
  @override
  void initState() {
    super.initState();
    cartBloc.add(GetProductsCartEvent(products: widget.cart?.products));
  }

  @override
  Widget build(BuildContext context) {
    String _date = widget.cart?.date != null
        ? DateFormat('dd/MM/yyyy HH:mm').format(widget.cart!.date!)
        : '';
    String _count = _countQuantity(widget.cart?.products);

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 2),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(width: 1)),
        child: Row(
          children: [
            BlocProvider.value(
              value: cartBloc,
              child: BlocBuilder<CartBloc, CartState>(
                bloc: cartBloc,
                builder: (context, state) {
                  if (state is ProductLoadedState) {
                    String imageURL = state.products?[0].products?.image ?? '';
                    return Expanded(
                      flex: 1,
                      child: Container(
                        height: 100,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(8),
                            image:
                                DecorationImage(image: NetworkImage(imageURL))),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: Container(),
                      flex: 1,
                    );
                  }
                },
              ),
            ),
            Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Time created: ' + _date,
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      'Number of products: ' + _count,
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  String _countQuantity(List<ProductQuantityEntity>? products) {
    if (products != null || products!.isNotEmpty) {
      int sum = 0;
      List<int> list_quantity =
          products.map((product) => product.quantity!).toList();
      for (final element in list_quantity) {
        sum += element;
      }
      return sum.toString();
    }
    return '0';
  }
}
