import 'package:delivery_app/routes/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get device dimensions
    final size = MediaQuery.of(context).size;
    final textScale = size.width * 0.05; // example: scale font based on width

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome to Ordering App",
                style: TextStyle(fontSize: textScale + 10),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: size.height * 0.03),
              ElevatedButton(
                onPressed: () => context.pushRoute(CategoriesRoute()),
                child: Text("Order Now", style: TextStyle(fontSize: textScale)),
              ),
              SizedBox(height: size.height * 0.02),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("App dismissed")),
                  );
                },
                child: Text("Dismiss", style: TextStyle(fontSize: textScale)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
