import 'package:delivery_app/routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/products_cubit.dart';
import '../data/product_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:auto_route/auto_route.dart';
import '../shared/bottom_nav_bar.dart';

@RoutePage()
class ProductsPage extends StatefulWidget {
  final String category;
  const ProductsPage({required this.category, Key? key}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  int _currentIndex = 0;
  String searchQuery = "";

  void _onBottomNavTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fontSize = size.width * 0.04;

    return BlocProvider(
      create: (_) => ProductsCubit(GetIt.I<ProductRepository>())
        ..fetchProducts(widget.category),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(widget.category,
              style: TextStyle(fontSize: fontSize + 4, color: Colors.black)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => context.router.pop(),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value.toLowerCase();
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  hintText: "Search",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Product List
            Expanded(
              child: BlocBuilder<ProductsCubit, ProductsState>(
                builder: (context, state) {
                  if (state is ProductsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProductsLoaded) {
                    final filteredProducts = state.products
                        .where((product) =>
                            product.title.toLowerCase().contains(searchQuery))
                        .toList();

                    return ListView.builder(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];

                        return GestureDetector(
                          onTap: () {
                            context.router
                                .push(ProductDetailRoute(id: product.id));
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 2,
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  // Product Image
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      product.image,
                                      width: size.width * 0.2,
                                      height: size.width * 0.2,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                            "assets/images/placeholder.png",
                                            width: size.width * 0.2,
                                            height: size.width * 0.2,
                                            fit: BoxFit.cover);
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10),

                                  // Product Details
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.title,
                                          style: TextStyle(
                                            fontSize: fontSize,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          "\$${product.price} / piece",
                                          style: TextStyle(
                                            fontSize: fontSize - 2,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Buttons: Favorite + Add to Cart
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.favorite_border,
                                            color: Colors.grey),
                                        onPressed: () {
                                          // Add functionality for favorites
                                        },
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        onPressed: () {
                                          // Add functionality for adding to cart
                                        },
                                        child: const Icon(Icons.shopping_cart,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is ProductsError) {
                    return const Center(
                      child: Icon(Icons.error, color: Colors.red, size: 40),
                    );
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onBottomNavTapped,
        ),
      ),
    );
  }
}

extension on StackRouter {
  pop() {}
}
