import 'package:ecom/providers/products_provider.dart';
import 'package:ecom/ui/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/category_provider.dart';
import '../widgets/products_row_widget.dart';

class AllProductsScreen extends ConsumerWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsNotifier = ref.watch(productsProvider);
    final categoryNotifier = ref.watch(categoryProvider);
  

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
              icon: const Icon(Icons.shopping_cart))
        ],
      ),
      body: Column(
        children: [
          SizedBox(
              height: 50,
              child: categoryNotifier.categoryList!.isNotEmpty
                  ? ListView.builder(
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            ref.read(productsProvider.notifier).getProductsList(
                                categoryNotifier.categoryList![index].slug);
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                    categoryNotifier.categoryList![index].name),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: categoryNotifier.categoryList!.length,
                      scrollDirection: Axis.horizontal)
                  : const Text('No Categories Found')),
          productsNotifier.isLoading
              ? const Padding(
                  padding: EdgeInsets.only(top: 100.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : SizedBox(
                  height: height - 170,
                  child: ListView.separated(
                    itemCount: productsNotifier.productsList!.length,
                    itemBuilder: (context, index) {
                      final currentProduct =
                          productsNotifier.productsList![index];
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
