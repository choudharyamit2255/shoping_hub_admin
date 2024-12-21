

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_hub_admin/product/model/product_model.dart';
import 'package:shoping_hub_admin/product/provider/product_provider.dart';


class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final nameController = TextEditingController();
  final desController = TextEditingController();
  final priceController = TextEditingController();
  final categoryIDController = TextEditingController();
  final idController = TextEditingController();
  final imageController = TextEditingController();
  final discountController = TextEditingController();
  final stockController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white70,
      appBar: AppBar(backgroundColor: Colors.blue,
        title: const Text('Add product'),
        actions: const [
           Padding(
             padding: EdgeInsets.only(right: 18.0),
             child: Icon(Icons.shop,color: Colors.black,),
           )
        ],
      ),
      body: getBody(),
    );
  }



  Widget getBody() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            mainTextFormField(nameController, 'Enter Product Name...'),
            mainTextFormField(desController, 'Enter Description...'),
            mainTextFormField(priceController, 'Enter Price...'),
            mainTextFormField(categoryIDController, 'Enter Category...'),

            mainTextFormField(imageController, 'Enter Image Url...'),
            mainTextFormField(discountController, 'Enter Discount...'),
            mainTextFormField(stockController, 'Enter Stock...'),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 20,backgroundColor: Colors.blue
                ),
                onPressed: addProductButton,
                child: const Text('Add New Product',style: TextStyle(color: Colors.black),),
              ),
            ),
          ],
        ),
      ),
    );
  }  Widget mainTextFormField(controller, hintText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(filled: true,
            hintText: hintText,border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
        ),
      ),
    );
  }

  void addProductButton() async {
    String name = nameController.text;
    String productId = idController.text.toString();
    String des = desController.text;
    double price = double.parse(priceController.text);
    String category = categoryIDController.text;
    num discountAmount = num.parse(discountController.text ?? "");

    String imgUrl = imageController.text ?? "";
    int stock = int.parse(stockController.text);

    ProductProvider provider = Provider.of<ProductProvider>(context, listen: false);
    Product product = Product(
      name: name,
     id : productId,
      description: des,
      price:  price,
      categoryId: category,
      discountAmount: discountAmount,
      image: imgUrl,
      stock: stock,
    );
    await provider.addProduct(product);
    if (mounted) {
      Navigator.pop(context);
      await provider.fetchProduct();
    }
  }



}