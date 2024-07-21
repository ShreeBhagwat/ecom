import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ecom/networking/api_endpoints.dart';
import 'package:ecom/networking/dio_client.dart';
import 'package:ecom/data/modals/products.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../modals/category.dart';

// DRY -> DoNot Repeat Yourself

class ProductsRepo {
  final DioClient _dioClient = DioClient();

  Future<List<Products>> getProducts(String? slug) async {
    List<Products> productsList = [];
    Response response;
    if (slug != null) {
      response = await _dioClient
          .get('${APIEndpoints.GetProductsByCategoryEndPoint}/$slug');
    } else {
      response = await _dioClient.get(APIEndpoints.GetProductsEndPoint);
    }
    if (response.statusCode == 200) {
      productsList = response.data['products']
          .map<Products>((product) => Products.fromJson(product))
          .toList();
      log(productsList.length.toString());
      return productsList;
    } else {
      log('Failed to get products');
      return Future.error('Failed to get products');
    }
  }

  Future<Products> getProductFromId({required String productId}) async {
    final response =
        await _dioClient.get('${APIEndpoints.GetProductsEndPoint}/$productId');
    log(response.data.toString());
    if (response.statusCode == 200) {
      final product = Products.fromJson(response.data);
      return product;
    } else {
      log('Failed to get product');
      return Future.error('Failed to get product');
    }
  }

  Future<List<CategoryModel>> getCategoryList() async {
    final response =
        await _dioClient.get(APIEndpoints.GetAllCategoriesEndPoint);
    log(response.data.toString());
    if (response.statusCode == 200) {
      final categoriesList = response.data
          .map<CategoryModel>((category) => CategoryModel.fromJson(category))
          .toList();
      log(categoriesList.length.toString());
      return categoriesList;
    } else {
      log('Failed to get categories');
      return Future.error('Failed to get categories');
    }
  }
}

final productsRepoProvider = Provider((ref) => ProductsRepo());
