import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/product_repository.dart';

abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final List<String> categories;
  CategoriesLoaded(this.categories);
}

class CategoriesError extends CategoriesState {
  final String error;
  CategoriesError(this.error);
}

class CategoriesCubit extends Cubit<CategoriesState> {
  final ProductRepository repository;

  CategoriesCubit(this.repository) : super(CategoriesInitial());

  void fetchCategories() async {
    emit(CategoriesLoading());
    try {
      final categories = await repository.fetchCategories();
      emit(CategoriesLoaded(categories));
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }
}
