import 'package:delivery_app/routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/categories_cubit.dart';
import '../data/product_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:auto_route/auto_route.dart';
import '../shared/bottom_nav_bar.dart';

@RoutePage()
class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  int _currentIndex = 0;

  void _onBottomNavTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    // Implement navigation or actions for Menu, Cart, Profile as needed.
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fontSize = size.width * 0.045; // adjust based on screen width

    return BlocProvider(
      create: (_) =>
          CategoriesCubit(GetIt.I<ProductRepository>())..fetchCategories(),
      child: Scaffold(
        appBar: AppBar(title: Text("Categories", style: TextStyle(fontSize: fontSize + 2))),
        body: BlocBuilder<CategoriesCubit, CategoriesState>(
          builder: (context, state) {
            if (state is CategoriesLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CategoriesLoaded) {
              return ListView.builder(
                padding: EdgeInsets.all(size.width * 0.05),
                itemCount: state.categories.length,
                itemBuilder: (context, index) {
                  final category = state.categories[index];
                  return ListTile(
                    title: Text(category, style: TextStyle(fontSize: fontSize)),
                    onTap: () {
                      context.router.push(ProductsRoute(category: category));
                    },
                  );
                },
              );
            } else if (state is CategoriesError) {
              return Center(child: Text("Error: ${state.error}", style: TextStyle(fontSize: fontSize)));
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
