import 'package:fakestore/features/auth/data/datasource/user_datasource.dart';
import 'package:fakestore/features/auth/data/repositories/user_repository_impl.dart';
import 'package:fakestore/features/auth/domain/repositories/user_repository.dart';
import 'package:fakestore/features/auth/domain/usecases/get_user.dart';
import 'package:fakestore/features/auth/domain/usecases/login.dart';
import 'package:fakestore/features/auth/domain/usecases/logout.dart';
import 'package:fakestore/features/auth/presentation/bloc/login_bloc.dart';
import 'package:fakestore/features/auth/presentation/view/login_page.dart';
import 'package:fakestore/features/cart/data/datasource/cart_datasource.dart';
import 'package:fakestore/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:fakestore/features/cart/domain/repositories/cart_repository.dart';
import 'package:fakestore/features/cart/domain/usecases/add_new_cart.dart';
import 'package:fakestore/features/cart/domain/usecases/get_cart_by_user_id.dart';
import 'package:fakestore/features/cart/domain/usecases/get_products_by_ids.dart';
import 'package:fakestore/features/cart/domain/usecases/update_cart.dart';
import 'package:fakestore/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:fakestore/features/cart/presentation/view/cart_page.dart';
import 'package:fakestore/features/cart/presentation/view/list_cart_page.dart';
import 'package:fakestore/features/product_details/data/repositories/product_details_repository_impl.dart';
import 'package:fakestore/features/product_details/domain/repositories/product_details_repository.dart';
import 'package:fakestore/features/product_details/domain/usecases/get_all_product.dart';
import 'package:fakestore/features/product_details/domain/usecases/get_product_by_category.dart';
import 'package:fakestore/features/product_details/presentation/bloc/product_bloc.dart';
import 'package:fakestore/features/product_details/presentation/view/homepage.dart';
import 'package:fakestore/features/product_details/presentation/view/product_view.dart';
import 'package:fakestore/features/utils/auth_guard/auth_guard.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/network/dio_client.dart';
import 'features/product_details/data/datasource/product_datasource.dart';

class AppModule extends Module {
  AppModule();

  @override
  void binds(Injector i) {
    i.addLazySingleton(() => DioClient());
    i.addLazySingleton<ProductDatasource>(
        () => ProductDatasourceImpl(dioClient: i.get<DioClient>()));
    i.addLazySingleton<ProductDetailsRepositories>(() =>
        ProductDetailsRepositoryImpl(
            productDatasource: i.get<ProductDatasource>()));
    i.addLazySingleton(() => GetAllProduct(
        productDetailsRepositories: i.get<ProductDetailsRepositories>()));
    i.addLazySingleton(() => GetProductByCategory(
        productDetailsRepositories: i.get<ProductDetailsRepositories>()));
    i.addLazySingleton(() => ProductBloc(
        getAllProduct: i.get<GetAllProduct>(),
        getProductByCategory: i.get<GetProductByCategory>()));
    i.addLazySingleton<UserRepository>(
        () => UserRepositoryImpl(userDatasource: i.get<UserDatasource>()));
    i.addLazySingleton<UserDatasource>(
        () => UserDatasourceImpl(dioClient: i.get<DioClient>()));
    i.addLazySingleton(() => Login(userRepository: i.get<UserRepository>()));
    i.addLazySingleton(() => GetUser(userRepository: i.get<UserRepository>()));
    i.addLazySingleton(() => Logout(userRepository: i.get<UserRepository>()));
    i.addLazySingleton(() => LoginBloc(
        login: i.get<Login>(),
        getUser: i.get<GetUser>(),
        logout: i.get<Logout>())
      ..add(CheckLoggedInEvent()));
    i.addLazySingleton<CartDatasource>(
        () => CartDatasourceImpl(dioClient: i.get<DioClient>()));
    i.addLazySingleton<CartRepository>(
        () => CartRepositoryImpl(cartDatasource: i.get<CartDatasource>()));
    i.addLazySingleton(
        () => GetCartByUserId(cartRepository: i.get<CartRepository>()));
    i.addLazySingleton(
        () => GetProductsByIds(cartRepository: i.get<CartRepository>()));
    i.addLazySingleton(
        () => AddNewCart(cartRepository: i.get<CartRepository>()));
    i.addLazySingleton(
        () => UpdateCart(cartRepository: i.get<CartRepository>()));
    i.addLazySingleton(() => CartBloc(
        getCartByUserId: i.get<GetCartByUserId>(),
        getProductsByIds: i.get<GetProductsByIds>(),
        addNewCart: i.get<AddNewCart>(),
        updateCart: i.get<UpdateCart>()));
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (contex) => Homepage());
    r.child('/product-view',
        child: (context) => ProductView(
              productEntity: r.args.data,
            ));
    r.child(
      '/login',
      child: (context) => LoginPage(),
    );
    r.child('/list-cart',
        child: (context) => ListCartPage(),
        guards: [AuthGuard(loginBloc: Modular.get<LoginBloc>())]);
    r.child('/cart',
        child: (context) => CartPage(),
        guards: [AuthGuard(loginBloc: Modular.get<LoginBloc>())]);
    r.child('/add-cart',
        child: (context) => CartPage(id: r.args.data),
        guards: [AuthGuard(loginBloc: Modular.get<LoginBloc>())]);
  }
}
