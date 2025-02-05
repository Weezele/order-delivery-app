import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/product_detail_cubit.dart';
import '../data/product_repository.dart';
import 'package:get_it/get_it.dart';

class ProductDetailPage extends StatelessWidget {
  final int id;
  const ProductDetailPage({required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductDetailCubit(GetIt.I<ProductRepository>())..fetchProductDetail(id),
      child: Scaffold(
        appBar: AppBar(title: Text("Product Details")),
        body: LayoutBuilder(
          builder: (context, constraints) {
            // Calculate responsive dimensions based on available width.
            final width = constraints.maxWidth;
            final padding = width * 0.05;
            final imageHeight = width * 0.5;
            final titleFontSize = width * 0.06;
            final priceFontSize = width * 0.05;
            final descFontSize = width * 0.045;

            return BlocBuilder<ProductDetailCubit, ProductDetailState>(
              builder: (context, state) {
                if (state is ProductDetailLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ProductDetailLoaded) {
                  final product = state.product;
                  return SingleChildScrollView(
                    padding: EdgeInsets.all(padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.network(
                            product.image,
                            height: imageHeight,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: padding),
                        Text(
                          product.title,
                          style: TextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: padding * 0.5),
                        Text(
                          "\$${product.price}",
                          style: TextStyle(
                            fontSize: priceFontSize,
                            color: Colors.green,
                          ),
                        ),
                        SizedBox(height: padding * 0.5),
                        Text(
                          product.description,
                          style: TextStyle(fontSize: descFontSize),
                        ),
                      ],
                    ),
                  );
                } else if (state is ProductDetailError) {
                  return Center(child: Text("Error: ${state.error}"));
                }
                return Container();
              },
            );
          },
        ),
      ),
    );
  }
}
