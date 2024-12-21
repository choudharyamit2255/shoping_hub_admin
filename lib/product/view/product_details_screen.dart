import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_hub_admin/cart/model/cart_model.dart';
import 'package:shoping_hub_admin/cart/provider/cart_provider.dart';
import 'package:shoping_hub_admin/cart/view/cart_screen.dart';
import 'package:shoping_hub_admin/product/model/product_model.dart';
import 'package:shoping_hub_admin/product/provider/product_provider.dart';
import 'package:shoping_hub_admin/product/view/update_product_screen.dart';
class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({required this.product, super.key});
  final Product product;
  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}
class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.product.name ?? ""),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                deleteProduct(context);
              },
              icon: const Icon(Icons.delete_forever, color: Colors.red),
            ),
          ),IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return CartScreen();
              }));
            },
            icon: const Icon(Icons.shopping_cart,color: Colors.black,),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  UpdateProductScreen(product: widget.product),
            ),
          );
          if (context.mounted) {
            Navigator.pop(context);
          }
        },
        child: const Icon(Icons.edit),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.product.image != null
                ? Image.network(
              widget.product.image??"",
              width: double.infinity,
              fit: BoxFit.cover,
            )
                : Container(
              height: 300,
              color: Colors.grey[300],
              child: Center(
                child: Icon(Icons.image, color: Colors.white),
              ),
            ),Divider(thickness: 2,color: Colors.black,),

              buildTextRow('Name',widget.product.name),
              buildTextRow('Price',widget.product.price.toString()),
              buildTextRow('DiscountAmount',widget.product.discountAmount.toString()),
              buildTextRow('Description',widget.product.description),
              buildTextRow('Stock',widget.product.stock.toString()),
              buildTextRow('Created',widget.product.created.toString()),
              buildTextRow('Modified',widget.product.modified.toString()),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () async {
                        CartProvider cartProvider =
                            Provider.of<CartProvider>(context, listen: false);
                        CartModel cartModel = CartModel(
                            productId: widget.product.id ?? '', quantity: 1);
                        await cartProvider.addToCart(cartModel);
                      },
                      style: ElevatedButton.styleFrom (
                        foregroundColor: Colors.black,
                      ),
                      child: const Text(
                        'Add to cart     ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildTextRow(String text,String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,   style: const TextStyle(fontWeight: FontWeight.bold)),
       Text(label)
      ],
    );
  }
  void deleteProduct(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Product"),
        content: const Text("Do you want to delete this product?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              final provider =
                  Provider.of<ProductProvider>(context, listen: false);
              if (widget.product.id != null) {
                await provider.deleteProduct(widget.product.id!);
                if (context.mounted) {
                  await provider.fetchProduct();
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              }
            },
            child: const Text("OK", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
  Widget buildProductDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
