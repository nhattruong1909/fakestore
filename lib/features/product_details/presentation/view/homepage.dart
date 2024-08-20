import 'package:fakestore/features/auth/presentation/bloc/login_bloc.dart';
import 'package:fakestore/features/product_details/presentation/bloc/product_bloc.dart';
import 'package:fakestore/features/product_details/presentation/widgets/custom_product_tile.dart';
import 'package:fakestore/features/product_details/presentation/widgets/custom_radio_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<String> categories = [
    'All',
    "Electronics",
    "Jewelery",
    "Men's clothing",
    "Women's clothing"
  ];
  List<String> categories_api = [
    'All',
    "electronics",
    "jewelery",
    "men's clothing",
    "women's clothing"
  ];
  int groupValue = 0;
  ProductBloc blocProduct = Modular.get<ProductBloc>();
  LoginBloc loginBloc = Modular.get<LoginBloc>();
  @override
  void initState() {
    super.initState();
    blocProduct.add(const ProductInitiateEvent());
    if (groupValue == 0) {
      blocProduct.add(const ProductGetAllEvent());
    } else {
      blocProduct
          .add(ProductGetByCategoryEvent(category: categories_api[groupValue]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Store',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Modular.to.pushNamed('/cart');
              },
              icon: Icon(Icons.shopping_cart)),
          BlocBuilder<LoginBloc, LoginState>(
              bloc: loginBloc,
              builder: (context, state) {
                return (state is LoginSuccess)
                    ? IconButton(
                        onPressed: () {
                          loginBloc.add(LogoutEvent());
                        },
                        icon: Icon(Icons.logout))
                    : IconButton(
                        onPressed: () {
                          Modular.to.pushNamed('/login');
                        },
                        icon: Icon(Icons.login));
              }),
        ],
      ),
      body: BlocProvider.value(
        value: blocProduct,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(categories.length, (index) {
                      return CustomRadioListTile(
                          value: index,
                          groupValue: groupValue,
                          label: categories[index],
                          onChanged: (value) {
                            setState(() {
                              groupValue = value!;
                            });
                            if (groupValue == 0) {
                              blocProduct.add(const ProductGetAllEvent());
                            } else {
                              blocProduct.add(ProductGetByCategoryEvent(
                                  category: categories_api[groupValue]));
                            }
                          });
                    }),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
                if (state is ProductInitialState) {
                  return const Center(child: Text('Initiatial'));
                } else if (state is ProductLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ProductLoadedState) {
                  return Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 8,
                      children: List.generate(state.listProduct?.length ?? 0,
                          (index) {
                        return InkWell(
                          onTap: () {
                            Modular.to.pushNamed('/product-view',
                                arguments: state.listProduct?[index]);
                          },
                          child: CustomProductTile(
                              imgUrl: state.listProduct?[index].image,
                              label: state.listProduct?[index].title,
                              price:
                                  state.listProduct?[index].price.toString()),
                        );
                      }),
                    ),
                  );
                } else if (state is ProductErrorState) {
                  return Center(
                    child: Text(
                      state.message ?? '',
                      style: const TextStyle(fontSize: 25),
                    ),
                  );
                } else {
                  return const Center(
                    child: Text(
                      'Unknown Error!',
                      style: TextStyle(fontSize: 25),
                    ),
                  );
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
