import 'package:ecom/data/modals/category.dart';
import 'package:ecom/data/repos/products_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryController {
  bool isLoading;
  List<CategoryModel>? categoryList;
  String? errorMessage;

  CategoryController({
    this.isLoading = false,
    this.categoryList,
    this.errorMessage,
  });

  CategoryController copyWith({
    bool? isLoading,
    List<CategoryModel>? categoryList,
    String? errorMessage,
  }) {
    return CategoryController(
      isLoading: isLoading ?? this.isLoading,
      categoryList: categoryList ?? this.categoryList,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class CategoryProvider extends StateNotifier<CategoryController> {
  final Ref ref;
  CategoryProvider(this.ref)
      : super(CategoryController(
          isLoading: false,
          categoryList: [],
        ));

  Future getCategoryList() async {
    await ref.read(productsRepoProvider).getCategoryList().then((categoryList) {
      state = state.copyWith(categoryList: categoryList, isLoading: false);
    }).catchError((e) {
      state = state.copyWith(
        isLoading: false,
        categoryList: [],
        errorMessage: e.toString(),
      );
    });
  }
}

final categoryProvider =
    StateNotifierProvider<CategoryProvider, CategoryController>(
        (ref) => CategoryProvider(ref));
