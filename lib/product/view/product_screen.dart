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

    Provider.of<ProductProvider>(context, listen: false).fetchProduct();
  }Future fetchProduct()async{
    final productProvider = Provider.of<ProductProvider>(context,listen: false);
    productProvider.fetchProduct();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Product Screen"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddProductScreen()));
          ProductProvider productProvider =
              Provider.of<ProductProvider>(context, listen: false);
          productProvider.fetchProduct();
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
              return Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ProductDetailsScreen(product: product);
                    }));
                  },
                  title: Text(
                    product.name ?? "",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(' ${product.description}'),
                  trailing: Text(
                    'Price: ₹${product.price}',
                    style: TextStyle(color: Colors.green),
                  ),

                ),
              );
            },
          );
        },
      ),
    );
  }

  }

