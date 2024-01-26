import 'package:fake_store_app/data/models/product_model.dart';
import 'package:fake_store_app/data/repository/dio_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc() : super(StoreState()) {
    on<StoreProductRequest>(_handleStoreProductRequest);
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
      emit(
        state.copyWith(
          productStatus: StoreResquest.requestError,
        ),
      );
    }
  }
}
