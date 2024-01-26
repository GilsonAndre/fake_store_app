import 'package:dio/dio.dart';
import 'package:fake_store_app/data/models/product_model.dart';

class DioRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://fakestoreapi.com/products',
    ),
  );

  Future<List<ProductModel>> getProducts() async {
    final response = await _dio.get('');

    return (response.data as List)
        .map(
          (map) => ProductModel(
            id: map['id'],
            title: map['title'],
            image: map['image'],
          ),
        )
        .toList();
  }
}
