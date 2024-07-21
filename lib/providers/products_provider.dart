import 'package:ecom/data/repos/products_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/modals/products.dart';

class ProductsController {
  final bool isLoading;
  List<Products>? productsList;
  String? erroMessage;

  ProductsController({
    this.isLoading = false,
    this.productsList,
    this.erroMessage,
  });

  ProductsController copyWith({
    bool? isLoading,
    List<Products>? productsList,
    String? erroMessage,
  }) {
    return ProductsController(
      isLoading: isLoading ?? this.isLoading,
      productsList: productsList ?? this.productsList,
      erroMessage: erroMessage ?? this.erroMessage,
    );
  }
}

class ProductsProvider extends StateNotifier<ProductsController> {
  final Ref ref;
  ProductsProvider(this.ref)
      : super(ProductsController(
          isLoading: false,
          productsList: [],
        ));

  Future getProductsList(String? slug) async {
    state = state.copyWith(isLoading: true);
    await ref.read(productsRepoProvider).getProducts(slug).then((productsList) {
      state = state.copyWith(productsList: productsList, isLoading: false);
    }).catchError((e) {
      state = state.copyWith(
          isLoading: false, productsList: [], erroMessage: e.toString());
    });
  }
}

final productsProvider =
    StateNotifierProvider<ProductsProvider, ProductsController>(
        (ref) => ProductsProvider(ref));
