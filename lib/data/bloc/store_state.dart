// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'store_bloc.dart';

enum StoreResquest {
  initial,
  requestInProgress,
  requestSucess,
  requestError,
}

class StoreState {
  final List<ProductModel> products;
  final Set<int> cartId;
  final StoreResquest productStatus;

  StoreState({
    this.products = const [],
    this.cartId = const {},
    this.productStatus = StoreResquest.initial,
  });

  StoreState copyWith({
    List<ProductModel>? products,
    Set<int>? cartId,
    StoreResquest? productStatus,
  }) {
    return StoreState(
      products: products ?? this.products,
      cartId: cartId ?? this.cartId,
      productStatus: productStatus ?? this.productStatus,
    );
  }
}
