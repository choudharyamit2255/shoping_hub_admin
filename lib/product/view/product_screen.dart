import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_hub_admin/product/provider/product_provider.dart';
import 'package:shoping_hub_admin/product/view/add_product_screen.dart';
import 'package:shoping_hub_admin/product/view/product_details_screen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
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
      appBar: customAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddProductScreen()));
          if (context.mounted) {
            ProductProvider productProvider =
            Provider.of<ProductProvider>(context, listen: false);
            productProvider.fetchProduct();
          }
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          if (productProvider.productList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: productProvider.productList.length,
            itemBuilder: (context, index) {
              final product = productProvider.productList[index];



              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(elevation: 5,
                  child: ListTile(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ProductDetailsScreen(product: product,);
                      }));

                    },
                    leading: product.image != null && product.image!.isNotEmpty
                        ? Image.network(
                      product.image!,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 60),
                    )
                        : const Icon(Icons.image_not_supported, size: 60),

                    title: Text(
                      product.name ?? "",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(' ${product.description}'),
                        Text(
                          'Discount: ₹${product.discountAmount?.toStringAsFixed(2)}',
                          style: const TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                    trailing: Text(
                      'Price: ₹${product.price}',
                      style: const TextStyle(color: Colors.green),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  AppBar customAppBar() {
    return AppBar(
      title: const Text("Product Screen"),
    );
  }
}
