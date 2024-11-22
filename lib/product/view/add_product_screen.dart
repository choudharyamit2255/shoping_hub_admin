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
  final categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add product'),
        actions: [
          Icon(Icons.shop)
        ],
      ),
      body: getBody(),
    );
  }



  Widget getBody() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          mainTextFormField(nameController, 'Enter Product Name...'),
          mainTextFormField(desController, 'Enter Description...'),
          mainTextFormField(priceController, 'Enter Price...'),
          mainTextFormField(categoryController, 'Enter Category...'),
          SizedBox(
            height: 20,
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 20,backgroundColor: Colors.blue
              ),
              onPressed: addProductButton,
              child: Text('Add New Product',style: TextStyle(color: Colors.black),),
            ),
          ),
        ],
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
    String des = desController.text;
    int price = int.parse(priceController.text);
    String category = categoryController.text;
    ProductProvider provider =
    Provider.of<ProductProvider>(context, listen: false);
    Product product = Product(
      name: name,
      description: des,
      price: price,
      category: category,
    );
    await provider.addProduct(product);
    Navigator.pop(context);

  }


}