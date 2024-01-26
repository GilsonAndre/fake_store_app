part of 'store_bloc.dart';

abstract class StoreEvent {
  StoreEvent();
}

class StoreProductRequest extends StoreEvent {}

class StoreProductAddedToCart extends StoreEvent {
  final int cartId;

  StoreProductAddedToCart(this.cartId);
}

class StoreProductRemoveFromCart extends StoreEvent {
  final int cartId;

  StoreProductRemoveFromCart(this.cartId);
}
