import 'dart:async';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fakestore/features/cart/domain/entities/product_details_quantity_entity.dart';
import 'package:fakestore/features/cart/domain/usecases/add_new_cart.dart';
import 'package:fakestore/features/cart/domain/usecases/get_cart_by_user_id.dart';
import 'package:fakestore/features/cart/domain/usecases/get_products_by_ids.dart';
import 'package:fakestore/features/cart/domain/usecases/update_cart.dart';
import 'package:fakestore/features/utils/model/cart_request_model.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/entities/product_quantity_entity.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(
      {required this.addNewCart,
      required this.updateCart,
      required this.getCartByUserId,
      required this.getProductsByIds})
      : super(CartInitial()) {
    on<CartEvent>((event, emit) {});
    on<GetCartsEvent>(_onGetCart);
    on<GetProductsCartEvent>(_onGetProduct);
    on<AddCartEvent>(_onAddCart);
    on<UpdateCartEvent>(_onUpdateCart);
  }
  final GetCartByUserId getCartByUserId;
  final GetProductsByIds getProductsByIds;
  final AddNewCart addNewCart;
  final UpdateCart updateCart;

  FutureOr<void> _onGetCart(
      GetCartsEvent event, Emitter<CartState> emit) async {
    emit(const CartLoadingState());
    var result = await getCartByUserId(event.id);
    result.fold((l) => emit(CartLoadingFailedState(message: l.message)),
        (r) => emit(CartLoadedState(carts: r)));
  }

  FutureOr<void> _onGetProduct(
      GetProductsCartEvent event, Emitter<CartState> emit) async {
    emit(const CartLoadingState());
    var result = await getProductsByIds(event.products);
    result.fold(
        (l) => emit(ProductLoadingFailedState(message: l.message)),
        (r) => emit(ProductLoadedState(
            products: r,
            sum: r!.fold<double>(
                0,
                (p, c) =>
                    p + c.quantity!.toDouble() * c.products!.price!.toDouble()),
            quantity: r!.fold(0, (p, c) => p + c.quantity!))));
  }

  FutureOr<void> _onAddCart(AddCartEvent event, Emitter<CartState> emit) async {
    var new_cart =
        CartRequestModel(userId: event.userId, date: event.date, products: [
      {'productId': event.productId, 'quantity': 1}
    ]);
    var result = await addNewCart(new_cart);
    result.fold((l) => emit(CartLoadingFailedState(message: l.message)),
        (r) async {
      this.add(GetProductsCartEvent(products: r?.products));
      // var product_result = await getProductsByIds(r?.products);
      // product_result.fold(
      //     (l) => emit(ProductLoadingFailedState(message: l.message)),
      //     (r) => emit(ProductLoadedState(products: r)));
    });
  }

  FutureOr<void> _onUpdateCart(
      UpdateCartEvent event, Emitter<CartState> emit) async {
    bool isExist = false;
    var new_list_product = event.cart?.products;
    var new_products_quantity = new_list_product
        ?.map((product) =>
            {'productId': product.productId, 'quantity': product.quantity})
        .toList();

    for (var product in new_products_quantity!) {
      if (product['productId'] == event.productId) {
        product['quantity'] = (product['quantity'] as int) + 1;
        isExist = true;
      }
    }
    if (isExist == false) {
      new_products_quantity.add({'productId': event.productId, 'quantity': 1});
    }
    var new_cart = CartRequestModel(
        id: event.cart?.id,
        userId: event.cart?.userId,
        date: event.date,
        products: new_products_quantity);
    var result = await updateCart(new_cart);
    result.fold((l) => emit(CartLoadingFailedState(message: l.message)),
        (r) async {
      this.add(GetProductsCartEvent(products: r?.products));
      // var product_result = await getProductsByIds(r?.products);
      // product_result.fold(
      //     (l) => emit(ProductLoadingFailedState(message: l.message)),
      //     (r) => emit(ProductLoadedState(products: r)));
    });
  }
}
