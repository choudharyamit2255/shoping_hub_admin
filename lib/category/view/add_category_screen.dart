import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_hub_admin/category/model/category_model.dart';
import 'package:shoping_hub_admin/category/provider/category_provider.dart';
import 'package:shoping_hub_admin/product/model/product_model.dart';
import 'package:shoping_hub_admin/product/provider/product_provider.dart';


class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final nameController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue,
        title: const Text('Add Category'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Icon(Icons.shop),
          )
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
          mainTextFormField(nameController, 'Enter Category Name...'),


          SizedBox(
            height: 20,
          ),
          Center(
            child: ElevatedButton(

              style: ElevatedButton.styleFrom(
                  elevation: 20,backgroundColor: Colors.blue
              ),
              onPressed: addCategoryButton,
              child: Text('Add New Category',style: TextStyle(color: Colors.black),),
            ),
          ),
        ],
      ),
    );
  }

  void addCategoryButton() async {
    String name = nameController.text;
    CategoryProvider provider =
    Provider.of<CategoryProvider>(context, listen: false);
    Category category = Category(
      name: name,
    );
    await provider.addCategory(category);
    Navigator.pop(context);
  }
  Widget mainTextFormField(controller, hintText) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(filled: true,
          hintText: hintText,border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
        ),
      ),
    );
  }
}