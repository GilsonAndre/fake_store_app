import 'package:fake_store_app/data/models/product_model.dart';
import 'package:fake_store_app/data/repository/dio_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc() : super(StoreState()) {
    on<StoreProductRequest>(_handleStoreProductRequest);
    on<StoreProductAddedToCart>(_handleStoreProductAddedToCart);
    on<StoreProductRemoveFromCart>(_handleStoreProductRemoveFromCart);
  }

  final DioRepository dioRepository = DioRepository();

  Future<void> _handleStoreProductRequest(
    StoreProductRequest event,
    Emitter<StoreState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          productStatus: StoreResquest.requestInProgress,
        ),
      );
      final response = await dioRepository.getProducts();

      emit(
        state.copyWith(
          productStatus: StoreResquest.requestSucess,
          products: response,
        ),
      );
    } catch (e) {
      print('o erro é $e');
      emit(
        state.copyWith(
          productStatus: StoreResquest.requestError,
        ),
      );
    }
  }

  Future<void> _handleStoreProductAddedToCart(
    StoreProductAddedToCart event,
    Emitter<StoreState> emit,
  ) async {
    emit(
      state.copyWith(
        cartId: {...state.cartId, event.cartId},
      ),
    );
  }

  Future<void> _handleStoreProductRemoveFromCart(
    StoreProductRemoveFromCart event,
    Emitter<StoreState> emit,
  ) async {
    emit(
      state.copyWith(
        cartId: {...state.cartId}..remove(event.cartId),
      ),
    );
  }
}
