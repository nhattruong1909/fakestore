part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class ProductInitiateEvent extends ProductEvent {
  const ProductInitiateEvent();
}

class ProductGetAllEvent extends ProductEvent {
  const ProductGetAllEvent();
}

// ignore: must_be_immutable
class ProductGetByCategoryEvent extends ProductEvent {
  ProductGetByCategoryEvent({this.category});
  String? category;
}
