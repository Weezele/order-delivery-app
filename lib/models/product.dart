// lib/models/product.dart
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
  });

  // A factory constructor for creating a new Product instance from a map.
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  // A method that converts this instance to a map.
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
