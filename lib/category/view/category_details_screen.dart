

import 'package:flutter/material.dart';
import 'package:shoping_hub_admin/category/model/category_model.dart';



class CategoryDetailsScreen extends StatelessWidget {
  CategoryDetailsScreen({required this.category,super.key});
final Category category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(backgroundColor: Colors.blue,
      title: Text(category.name??""),),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text('CategoryName: ${category.name}',style: TextStyle(fontWeight: FontWeight.bold),),
          Text('CategorysId:   ${category.sId}',style: TextStyle(fontWeight: FontWeight.bold)),
          Text('CategoryIv:   ${category.iV}',style: TextStyle(fontWeight: FontWeight.bold)),

        ],),
      ) ,
    );
  }
}
