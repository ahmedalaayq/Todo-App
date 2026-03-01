import 'package:flutter/material.dart';
import 'package:todo_app/core/router/app_routes.dart';

class NoRouteFoundView extends StatelessWidget {
  const NoRouteFoundView({super.key, required this.routeName});
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated icon
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: const Duration(seconds: 1),
                  curve: Curves.elasticOut,
                  builder: (context, value, child) =>
                      Transform.scale(scale: value, child: child),
                  child: Icon(
                    Icons.error_outline,
                    size: 120,
                    color: Colors.redAccent.shade400,
                  ),
                ),

                const SizedBox(height: 32),

                // Title
                Text(
                  "Oops!",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade900,
                  ),
                ),

                const SizedBox(height: 16),

                // Description
                Text(
                  "No route found ($routeName) .\nThe page you're looking for doesn't exist.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blueGrey.shade700,
                  ),
                ),

                const SizedBox(height: 32),

                // Button
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).pushReplacementNamed(AppRoutes.welcomeView);
                  },
                  icon: const Icon(Icons.home),
                  label: const Text("Go Home"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.blueAccent,
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
