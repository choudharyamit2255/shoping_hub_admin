import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shoping_hub_admin/product/model/product_model.dart';
import 'package:shoping_hub_admin/product/provider/product_provider.dart';
import 'package:shoping_hub_admin/product/view/product_details_screen.dart';

class ProductWeb extends StatefulWidget {
  const ProductWeb({super.key});

  @override
  State<ProductWeb> createState() => _ProductWebState();
}

class _ProductWebState extends State<ProductWeb> {
  @override
  void initState() {
    fetchProduct();
    super.initState();
  }

  Future fetchProduct() async {
    final productProvider =
    Provider.of<ProductProvider>(context, listen: false);
    productProvider.fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [

                // Grid of Products
                Expanded(
                  child: Consumer<ProductProvider>(
                    builder: (context, productProvider, child) {
                      if (productProvider.productList.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.70,
                        ),
                        itemCount: productProvider.productList.length,
                        itemBuilder: (context, index) {
                          Product product = productProvider.productList[index];

                          num finalPrice = product.discountAmount != null
                              ? product.price! * (1 - product.discountAmount! / 100)
                              : product.price!;

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailsScreen(product: product),
                                ),
                              );
                            },
                            child: Card(
                              elevation: 5,
                              margin: const EdgeInsets.all(8.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // Product Image
                                  product.image != null
                                      ? Image.network(
                                    product.image!,
                                    width: double.infinity,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  )
                                      : const Icon(Icons.image_not_supported, size: 100),

                                  const SizedBox(height: 10),

                                  // Product Name
                                  Text(
                                    product.name ?? '',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 5),

                                  // Price
                                  Text(
                                    '₹${finalPrice.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.green,
                                    ),
                                  ),

                                  // Discount (If Available)
                                  if (product.discountAmount != null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4.0),
                                      child: Text(
                                        'Discount: ₹${product.discountAmount?.toStringAsFixed(0)}',
                                        style: const TextStyle(
                                          color: Colors.green,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
