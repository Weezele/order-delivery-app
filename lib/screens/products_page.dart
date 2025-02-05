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
  const ProductsPage({required this.category});

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  int _currentIndex = 0;

  void _onBottomNavTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    // Implement additional navigation or actions.
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fontSize = size.width * 0.04;

    return BlocProvider(
      create: (_) => ProductsCubit(GetIt.I<ProductRepository>())
        ..fetchProducts(widget.category),
      child: Scaffold(
        appBar: AppBar(
            title: Text("Products - ${widget.category}",
                style: TextStyle(fontSize: fontSize + 2))),
        body: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            if (state is ProductsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ProductsLoaded) {
              return ListView.builder(
                padding: EdgeInsets.all(size.width * 0.05),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return ListTile(
                    leading: Image.network(product.image,
                        width: size.width * 0.12,
                        height: size.width * 0.12,
                        fit: BoxFit.contain),
                    title: Text(product.title,
                        style: TextStyle(fontSize: fontSize)),
                    subtitle: Text("\$${product.price}",
                        style: TextStyle(fontSize: fontSize)),
                    onTap: () {
                      context.pushRoute(ProductDetailRoute(id: product.id));
                    },
                  );
                },
              );
            } else if (state is ProductsError) {
              return Center(
                  child: Text("Error: ${state.error}",
                      style: TextStyle(fontSize: fontSize)));
            }
            return Container();
          },
        ),
        bottomNavigationBar: CustomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onBottomNavTapped,
        ),
      ),
    );
  }
}
