import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_hub_admin/product/model/product_model.dart';
import 'package:shoping_hub_admin/product/provider/product_provider.dart';



class UpdateProductScreen extends StatefulWidget {
  final Product product;
  const UpdateProductScreen({super.key, required this.product});

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final nameController = TextEditingController();
  final desController = TextEditingController();
  final priceController = TextEditingController();
  final categoryIDController = TextEditingController();
  final idController = TextEditingController();
  final imageController = TextEditingController();
  final discountController = TextEditingController();
  final stockController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.product.name ?? '';
    desController.text = widget.product.description ?? '';
    priceController.text = widget.product.price.toString() ?? '';
    // categoryIDController.text = widget.product.categoryId??"";

    imageController.text = widget.product.image??"";
    discountController.text = widget.product.discountAmount.toString();
    stockController.text = widget.product.stock.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration:  InputDecoration(hintText: 'Product Name',border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
              ),const SizedBox(height: 10,),
              TextField(
                controller: desController,
                decoration:  InputDecoration(hintText: 'Description',border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
              ),const SizedBox(height: 10,),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration:  InputDecoration(hintText: 'Price',border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
              ),const SizedBox(height: 10,), TextField(
                controller: categoryIDController,
          
                decoration:  InputDecoration(hintText: 'CategoryId',border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
          
              ),const SizedBox(height: 10,), TextField(
                controller: imageController,
          
                decoration:  InputDecoration(hintText: 'Product Image Url',border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
              ),const SizedBox(height: 10,), TextField(
                controller: discountController,
                keyboardType: TextInputType.number,
                decoration:  InputDecoration(hintText: 'Product Discount',border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
              ),const SizedBox(height: 10,), TextField(
                controller: stockController,
                keyboardType: TextInputType.number,
                decoration:  InputDecoration(hintText: 'Stock',border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final updatedProduct = Product(
                    id: widget.product.id,
                    name: nameController.text,
                    description: desController.text,
                    price: double.parse(priceController.text),
                     // categoryId: categoryIDController.text,
                      discountAmount: num.parse(discountController.text),
                       stock: int.parse(stockController.text),
                    image: imageController.text,
                  );
          
                  await Provider.of<ProductProvider>(context, listen: false)
                      .updateProduct(widget.product.id!, updatedProduct);
          
                       if(context.mounted) {
                         Navigator.pop(context);
                       }  },
                child: const Text('Update Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
