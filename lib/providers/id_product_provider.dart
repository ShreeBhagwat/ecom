// class ProductFromIdProvider

import 'package:ecom/data/modals/products.dart';
import 'package:ecom/data/repos/products_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productsFromIdProvider =
    FutureProvider.family<Products, String>((ref, id) async {
  return await ref.read(productsRepoProvider).getProductFromId(productId: id);
});
