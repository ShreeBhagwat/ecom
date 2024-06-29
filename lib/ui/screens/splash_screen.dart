import 'package:ecom/ui/screens/all_products_screen.dart';
import 'package:ecom/data/repos/products_repo.dart';
import 'package:flutter/material.dart';

import '../../data/modals/products.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final ProductsRepo _productsRepo = ProductsRepo();

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  Future getProducts() async {
    await _productsRepo.getProducts(null).then((productsList) async {
      await _productsRepo.getCategoryList().then((categoryList) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => AllProductsScreen(
              productsList: productsList,
              categoryList: categoryList,
            ),
          ),
        );
      
      });
    });
  }

  Future getCategoryList() async {
    await _productsRepo.getCategoryList();
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
