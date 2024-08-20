import 'package:fakestore/features/cart/presentation/bloc/cart_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../auth/presentation/bloc/login_bloc.dart';
import '../widgets/list_cart_row.dart';

class ListCartPage extends StatefulWidget {
  const ListCartPage({super.key});
  @override
  State<ListCartPage> createState() => _ListCartPageState();
}

class _ListCartPageState extends State<ListCartPage> {
  CartBloc blocCart = Modular.get<CartBloc>();
  LoginBloc loginBloc = Modular.get<LoginBloc>();
  @override
  void initState() {
    super.initState();
    blocCart.add(GetCartsEvent(id: (loginBloc.state as LoginSuccess).user!.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'List Cart',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Modular.to.popAndPushNamed('/');
                },
                icon: Icon(Icons.home))
          ],
        ),
        body: BlocProvider.value(
          value: blocCart,
          child: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
            if (state is CartLoadingFailedState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message ?? '')));
              return const Center(
                child: Text('No cart or error.'),
              );
            } else if (state is CartLoadingState || state is CartInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CartLoadedState) {
              return ListView.builder(
                  itemCount: state.carts?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                        onTap: () => Modular.to.pushNamed('/list-cart/cart',
                            arguments: state.carts?[index].products),
                        child: ListCartRow(
                          cart: state.carts?[index],
                        ));
                  });
            } else {
              return const Center(
                child: Text('Error!'),
              );
            }
          }),
        ));
  }
}
