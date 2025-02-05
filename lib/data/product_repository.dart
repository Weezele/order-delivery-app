import 'package:injectable/injectable.dart';
import '../models/product.dart';
import 'api_client.dart';

@lazySingleton
class ProductRepository {
  final ApiClient apiClient;

  ProductRepository(this.apiClient);

  Future<List<Product>> fetchAllProducts() => apiClient.getAllProducts();

  Future<List<String>> fetchCategories() => apiClient.getCategories();

  Future<List<Product>> fetchProductsByCategory(String category) =>
      apiClient.getProductsByCategory(category);

  Future<Product> fetchProductDetail(int id) => apiClient.getProduct(id);
}
