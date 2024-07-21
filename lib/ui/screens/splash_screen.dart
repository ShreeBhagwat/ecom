import 'package:ecom/providers/category_provider.dart';
import 'package:ecom/providers/products_provider.dart';
import 'package:ecom/ui/screens/all_products_screen.dart';
import 'package:ecom/data/repos/products_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/modals/products.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async{
     await  getProducts();
    });
  }

  Future getProducts() async {
    await ref.read(productsProvider.notifier).getProductsList(null);
    await ref.read(categoryProvider.notifier).getCategoryList().then((value) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const AllProductsScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}
