import 'package:ecom/data/modals/products.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartProvider extends StateNotifier<List<Products>> {
  CartProvider() : super([]);

  void addToCart(Products product) {
    state = state..add(product);
  }

  void removeFromCart(Products products) {
    state = state.where((element) => element.id != products.id).toList();
  }
}

final cartProvider = StateNotifierProvider<CartProvider, List<Products>>(
  (ref) => CartProvider(),
);
