import 'package:ecom/data/modals/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/cart_provider.dart';
import '../../providers/id_product_provider.dart';

class ProductDetailScreen extends ConsumerWidget {
  const ProductDetailScreen({super.key, required this.productId});
  final String productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<Products> product = ref.watch(productsFromIdProvider(productId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
      ),
      body: product.when(
        data: (product) {
          return ProductsDetailsWidget(product: product);
        },
        error: (error, trace) {
          return Center(
            child: Text('Error: $error'),
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class ProductsDetailsWidget extends ConsumerWidget {
  const ProductsDetailsWidget({
    super.key,
    required this.product,
  });

  final Products product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        children: [
          Text(product.title!),
          Image.network(
            product.images!.first,
            width: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(product.description!),
          ),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                ref.read(cartProvider.notifier).addToCart(product);
              },
              child: const Text('Add To Cart'),
            ),
          )
        ],
      ),
    );
  }
}
