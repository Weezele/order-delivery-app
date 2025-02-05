import 'package:auto_route/auto_route.dart';
import 'package:delivery_app/routes/app_router.gr.dart';

@AutoRouterConfig(generateForDir: ['lib/screens'])
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          initial: true,
          page: SplashRoute.page,
        ),
        AutoRoute(
          page: CategoriesRoute.page,
        ),
        AutoRoute(
          page: ProductsRoute.page,
        ),
        AutoRoute(
          page: ProductDetailRoute.page,
          path: '/product/:id', 
        ),
      ];
}
