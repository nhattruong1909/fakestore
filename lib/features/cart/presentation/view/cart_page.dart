import 'package:fakestore/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:fakestore/features/cart/presentation/widgets/cart_bottom_appbar.dart';
import 'package:fakestore/features/cart/presentation/widgets/cart_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

import '../../../auth/presentation/bloc/login_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key, this.id = 0});
  final int? id;
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartBloc cartBloc = Modular.get<CartBloc>();
  LoginBloc loginBloc = Modular.get<LoginBloc>();

  @override
  void initState() {
    super.initState();
    cartBloc.add(GetCartsEvent(id: (loginBloc.state as LoginSuccess).user!.id));
  }

  @override
  Widget build(BuildContext context) {
    int totalPrice = 0;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Your Cart',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Modular.to.navigate('/');
                },
                icon: Icon(Icons.home))
          ]),
      bottomNavigationBar: CartBottomAppbar(totalPrice: totalPrice),
      body: BlocProvider.value(
        value: cartBloc,
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is ProductLoadedState) {
              if (state.products != null && state.products!.isNotEmpty) {
                return ListView.builder(
                    itemCount: state.products?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return CartRow(
                        product: state.products?[index],
                      );
                    });
              } else {
                return Center(
                  child: Text(
                    'No product',
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
                  ),
                );
              }
            } else if (state is ProductLoadingFailedState ||
                state is CartLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CartLoadedState) {
              if (state.carts == null || state.carts!.isEmpty) {
                if (widget.id == 0) {
                  return Center(
                    child: Text(
                      'No product',
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
                    ),
                  );
                }
                var now = DateTime.now();
                var formatter = DateFormat('yyyy-MM-dd');
                String formattedDate = formatter.format(now);
                cartBloc.add(AddCartEvent(
                    productId: widget.id,
                    date: formattedDate,
                    userId: (loginBloc.state as LoginSuccess).user!.id));
              }
              if (widget.id != 0) {
                var now = DateTime.now();
                var formatter = DateFormat('yyyy-MM-dd');
                String formattedDate = formatter.format(now);
                cartBloc.add(UpdateCartEvent(
                    productId: widget.id,
                    date: formattedDate,
                    cart: state.carts?[0]));
              } else {
                cartBloc.add(
                    GetProductsCartEvent(products: state.carts?[0].products));
              }
              return Container();
            } else if (state is CartLoadingFailedState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.message ?? 'Unexpected Error.')));
              return const Center(child: Text('No product or error.'));
            } else {
              return const Center(child: Text('No product or error.'));
            }
          },
        ),
      ),
    );
  }
}
