import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/product.dart';
part 'api_client.g.dart';

@RestApi(baseUrl: "https://fakestoreapi.com")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("/products")
  Future<List<Product>> getAllProducts();

  @GET("/products/category/{category}")
  Future<List<Product>> getProductsByCategory(@Path("category") String category);

  @GET("/products/{id}")
  Future<Product> getProduct(@Path("id") int id);

  @GET("/products/categories")
  Future<List<String>> getCategories();
}
