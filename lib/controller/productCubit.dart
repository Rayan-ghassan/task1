import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:task1/models/product.dart';


class ProductCubit extends Cubit<List<Product>> {
  ProductCubit() : super([]);

  void fetchProducts() async {
    try {
      final response = await Dio().get('https://dummyjson.com/products');
      List<Product> products = (response.data['products'] as List)
          .map((json) => Product.fromJson(json))
          .toList();
      emit(products);
    } catch (e) {
      print("Error fetching products: $e");
    }
  }
}