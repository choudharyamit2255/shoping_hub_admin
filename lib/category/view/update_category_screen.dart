import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_hub_admin/category/provider/category_provider.dart';
import 'package:shoping_hub_admin/category/model/category_model.dart';

class UpdateCategoryScreen extends StatefulWidget {
  final Category category;

  const UpdateCategoryScreen({super.key, required this.category});

  @override
  State<UpdateCategoryScreen> createState() => _UpdateCategoryScreenState();
}

class _UpdateCategoryScreenState extends State<UpdateCategoryScreen> {
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.category.name ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Category')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: 'Category Name'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final updatedProduct = Category(
                  sId: widget.category.sId,
                  name: nameController.text,

                );

                await Provider.of<CategoryProvider>(context, listen: false)
                    .updateCategory(widget.category.sId!, updatedProduct);
                if(context.mounted){
                  Navigator.pop(context);

                }},
              child: const Text('Update Category'),
            ),
          ],
        ),
      ),
    );
  }
}