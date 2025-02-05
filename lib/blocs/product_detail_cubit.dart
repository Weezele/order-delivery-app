import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product.dart';
import '../data/product_repository.dart';

abstract class ProductDetailState {}

class ProductDetailInitial extends ProductDetailState {}

class ProductDetailLoading extends ProductDetailState {}

class ProductDetailLoaded extends ProductDetailState {
  final Product product;
  ProductDetailLoaded(this.product);
}

class ProductDetailError extends ProductDetailState {
  final String error;
  ProductDetailError(this.error);
}

class ProductDetailCubit extends Cubit<ProductDetailState> {
  final ProductRepository repository;

  ProductDetailCubit(this.repository) : super(ProductDetailInitial());

  void fetchProductDetail(int id) async {
    emit(ProductDetailLoading());
    try {
      final product = await repository.fetchProductDetail(id);
      emit(ProductDetailLoaded(product));
    } catch (e) {
      emit(ProductDetailError(e.toString()));
    }
  }
}
