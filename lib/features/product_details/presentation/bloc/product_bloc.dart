import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fakestore/features/product_details/domain/usecases/get_all_product.dart';
import 'package:fakestore/features/product_details/domain/usecases/get_product_by_category.dart';

import '../../../../core/commondomain/usecase/usecase.dart';
import '../../domain/entities/product_entity.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({required this.getAllProduct, required this.getProductByCategory})
      : super(const ProductInitialState()) {
    on<ProductEvent>((event, emit) {});
    on<ProductInitiateEvent>(_onInitiate);
    on<ProductGetAllEvent>(_onGetAll);
    on<ProductGetByCategoryEvent>(_onGetByCategory);
  }

  final GetAllProduct getAllProduct;
  final GetProductByCategory getProductByCategory;

  FutureOr<void> _onInitiate(
      ProductInitiateEvent event, Emitter<ProductState> emit) async {
    emit(const ProductInitialState());
  }

  FutureOr<void> _onGetAll(
      ProductGetAllEvent event, Emitter<ProductState> emit) async {
    emit(const ProductLoadingState());
    var result = await getAllProduct(NoParams());
    result.fold((l) => emit(ProductErrorState(message: l.message)),
        (r) => emit(ProductLoadedState(r)));
  }

  FutureOr<void> _onGetByCategory(
      ProductGetByCategoryEvent event, Emitter<ProductState> emit) async {
    emit(const ProductLoadingState());
    var result = await getProductByCategory(event.category);
    result.fold((l) => emit(ProductErrorState(message: l.message)),
        (r) => emit(ProductLoadedState(r)));
  }
}
