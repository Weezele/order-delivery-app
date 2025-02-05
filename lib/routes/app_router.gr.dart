// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:delivery_app/screens/categories_page.dart' as _i1;
import 'package:delivery_app/screens/product_detail_page.dart' as _i2;
import 'package:delivery_app/screens/products_page.dart' as _i3;
import 'package:delivery_app/screens/splash_screen.dart' as _i4;

/// generated route for
/// [_i1.CategoriesPage]
class CategoriesRoute extends _i4.PageRouteInfo<void> {
  const CategoriesRoute({List<_i4.PageRouteInfo>? children})
      : super(
          CategoriesRoute.name,
          initialChildren: children,
        );

  static const String name = 'CategoriesRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return _i1.CategoriesPage();
    },
  );
}

/// generated route for
/// [_i2.ProductDetailPage]
class ProductDetailRoute extends _i4.PageRouteInfo<ProductDetailRouteArgs> {
  ProductDetailRoute({
    required int id,
    List<_i4.PageRouteInfo>? children,
  }) : super(
          ProductDetailRoute.name,
          args: ProductDetailRouteArgs(id: id),
          initialChildren: children,
        );

  static const String name = 'ProductDetailRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductDetailRouteArgs>();
      return _i2.ProductDetailPage(id: args.id); // Pass the required `id`
    },
  );
}

class ProductDetailRouteArgs {
  const ProductDetailRouteArgs({required this.id});

  final int id; // Non-nullable `int`

  @override
  String toString() {
    return 'ProductDetailRouteArgs{id: $id}';
  }
}

/// generated route for
/// [_i3.ProductsPage]
class ProductsRoute extends _i4.PageRouteInfo<ProductsRouteArgs> {
  ProductsRoute({
    required String category,
    List<_i4.PageRouteInfo>? children,
  }) : super(
          ProductsRoute.name,
          args: ProductsRouteArgs(category: category),
          initialChildren: children,
        );

  static const String name = 'ProductsRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductsRouteArgs>();
      return _i3.ProductsPage(category: args.category);
    },
  );
}

class ProductsRouteArgs {
  const ProductsRouteArgs({required this.category});

  final String category;

  @override
  String toString() {
    return 'ProductsRouteArgs{category: $category}';
  }
}

/// generated route for
/// [_i4.SplashScreen]
class SplashRoute extends _i4.PageRouteInfo<void> {
  const SplashRoute({List<_i4.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return _i4.SplashScreen();
    },
  );
}
