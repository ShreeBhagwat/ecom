import 'package:ecom/data/modals/products.dart';
import 'package:ecom/data/repos/products_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.productId});
  final String productId;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  Products? product;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductDetail();
  }

  Future getProductDetail() async {
    final ProductsRepo _productsRepo = ProductsRepo();
    product = await _productsRepo.getProductFromId(productId: widget.productId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Product Detail'),
        ),
        body: product == null
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              )
            : Center(
                child: Column(
                  children: [
                    Text(product!.title!),
                    Image.network(
                      product!.images!.first,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(product!.description!),
                    ),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('Add To Cart'),
                      ),
                    )
                  ],
                ),
              ));
  }
}
