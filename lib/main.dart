import 'package:ecom/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Ecom());
}

class Ecom extends StatelessWidget {
  const Ecom({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}
