import 'package:ecom/data/modals/products.dart';
import 'package:ecom/data/repos/products_repo.dart';
import 'package:ecom/ui/screens/cart_screen.dart';
import 'package:flutter/material.dart';

import '../../data/modals/category.dart';
import '../widgets/products_row_widget.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen(
      {super.key, required this.productsList, required this.categoryList});

  final List<Products> productsList;
  final List<CategoryModel> categoryList;

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  List<Products>? productsList;
  final ProductsRepo _productsRepo = ProductsRepo();
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    productsList = widget.productsList;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Prodcuts',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const CartScreen(),
                  ),
                );
              },
              icon: Icon(Icons.shopping_cart))
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      productsList = await _productsRepo
                          .getProducts(widget.categoryList[index].slug);
                      setState(() {
                        isLoading = false;
                      });
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(widget.categoryList[index].name),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: widget.categoryList.length,
                scrollDirection: Axis.horizontal),
          ),
          isLoading
              ? const Padding(
                  padding: EdgeInsets.only(top: 100.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : SizedBox(
                  height: height - 170,
                  child: ListView.separated(
                    itemCount: productsList!.length,
                    itemBuilder: (context, index) {
                      final currentProduct = productsList![index];
                      return ProductsRow(currentProduct: currentProduct);
                    },
                    separatorBuilder: (context, index) => const Divider(),
                  ),
                ),
        ],
      ),
    );
  }
}
