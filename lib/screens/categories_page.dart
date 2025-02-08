import 'package:delivery_app/routes/app_router.gr.dart';
import 'package:delivery_app/shared/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/categories_cubit.dart';
import '../data/product_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  int _currentIndex = 0;
  String searchQuery = "";

  void _onBottomNavTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final Map<String, String> categoryImages = {
    "electronics": "assets/categories/electronics.png",
    "jewelery": "assets/categories/jewelry.png",
    "men's clothing": "assets/categories/mens_clothing.png",
    "women's clothing": "assets/categories/womens_clothing.png",
  };

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fontSize = size.width * 0.045;

    return BlocProvider(
      create: (_) =>
          CategoriesCubit(GetIt.I<ProductRepository>())..fetchCategories(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Categories", style: TextStyle(fontSize: fontSize + 2)),
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => context.router.pop(),
          ),
        ),
        body: Column(
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
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  hintText: "Search",
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Categories Grid
            Expanded(
              child: BlocBuilder<CategoriesCubit, CategoriesState>(
                builder: (context, state) {
                  if (state is CategoriesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CategoriesLoaded) {
                    final filteredCategories = state.categories
                        .where((category) =>
                            category.toLowerCase().contains(searchQuery))
                        .toList();

                    return GridView.builder(
                      padding: EdgeInsets.all(size.width * 0.05),
                      itemCount: filteredCategories.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        final category = filteredCategories[index];
                        final imageUrl = categoryImages[category] ??
                            "assets/categories/placeholder.png";

                        return GestureDetector(
                          onTap: () {
                            context.router
                                .push(ProductsRoute(category: category));
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    child: Image.asset(
                                      imageUrl,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                            "assets/categories/placeholder.png"); // Fallback
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        category,
                                        style: TextStyle(
                                          fontSize: fontSize,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "(${(index + 1) * 10} items)", // Fake count
                                        style: TextStyle(
                                          fontSize: fontSize - 2,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is CategoriesError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Error: ${state.error}",
                            style: TextStyle(
                                fontSize: fontSize, color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () => context
                                .read<CategoriesCubit>()
                                .fetchCategories(),
                            child: const Text("Retry"),
                          ),
                        ],
                      ),
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
