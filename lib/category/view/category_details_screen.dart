
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_hub_admin/category/model/category_model.dart';
import 'package:shoping_hub_admin/category/provider/category_provider.dart';
import 'package:shoping_hub_admin/category/view/update_category_screen.dart';
class CategoryDetailsScreen extends StatefulWidget {
  const CategoryDetailsScreen({required this.category,super.key});
final Category category;

  @override
  State<CategoryDetailsScreen> createState() => _CategoryDetailsScreenState();
}

class _CategoryDetailsScreenState extends State<CategoryDetailsScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(appBar: AppBar(backgroundColor: Colors.blue,
      title: Text(widget.category.name??""),  actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: IconButton(
            onPressed: () {
              deleteCategory(context);
            },
            icon: const Icon(Icons.delete_forever, color: Colors.red),
          ),
        ),
      ],),  floatingActionButton: FloatingActionButton(
      onPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UpdateCategoryScreen(category: widget.category),
          ),
        );
        if(context.mounted) {
          Navigator.pop(context);
        }  },
      child: const Icon(Icons.edit),
    ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text('CategoryName: ${widget.category.name}',style: const TextStyle(fontWeight: FontWeight.bold),),
          Text('CategorySId:   ${widget.category.sId}',style: const TextStyle(fontWeight: FontWeight.bold)),
          Text('CategoryIv:   ${widget.category.iV}',style: const TextStyle(fontWeight: FontWeight.bold)),

        ],),
      ) ,
    );
  }

  void deleteCategory(BuildContext context) {
    showDialog(context: context, builder: (context)=>AlertDialog(
      title: const Text("Delete Category"),
      content: const Text("Do You want to delete this Category?"),
      actions: [
        TextButton(onPressed: (){
        }, child: const Text("Cancel")),
        TextButton(
            onPressed: ()async{
          final categoryProvider = Provider.of<CategoryProvider>(context,listen: false);

          await categoryProvider.deleteCategory(widget.category.sId!);
          if(widget.category.sId != null) {
            if(categoryProvider.errorMessage==null) {
            }
            if(context.mounted) {
              Navigator.pop(context);
                 categoryProvider.fetchCategory();
                 Navigator.pop(context);
            }
          }

        }, child: const Text("OK",style: TextStyle(color: Colors.red),))
      ],
    ));
  }
}
