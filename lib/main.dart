import 'package:delivery_app/injection/injection.dart';
import 'package:delivery_app/routes/app_router.dart';
import 'package:flutter/material.dart';


void main() {
  // Initialize dependency injection
  configureDependencies();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  // Instantiate the router. This assumes you have defined AppRouter in app_router.dart.
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Ordering App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Using Material 3 with a seeded color scheme for consistent theming.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Use the new routerConfig API from auto_route v6+.
      routerConfig: _appRouter.config(),
    );
  }
}
