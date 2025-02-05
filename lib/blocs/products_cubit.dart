import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product.dart';
import '../data/product_repository.dart';

abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<Product> products;
  ProductsLoaded(this.products);
}

class ProductsError extends ProductsState {
  final String error;
  ProductsError(this.error);
}

class ProductsCubit extends Cubit<ProductsState> {
  final ProductRepository repository;

  ProductsCubit(this.repository) : super(ProductsInitial());

  void fetchProducts(String category) async {
    emit(ProductsLoading());
    try {
      final products = await repository.fetchProductsByCategory(category);
      emit(ProductsLoaded(products));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }
}
