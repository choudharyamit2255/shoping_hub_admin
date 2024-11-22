import 'package:flutter/material.dart';
import 'package:shoping_hub_admin/product/model/product_model.dart';



class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({required this.product ,super.key});
 final Product product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue,
        title: Text(product.name??""),),
      body:
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text('Name:  ${product.name??""}',style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Price: ₹${product.price??""}',style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Description:   ${product.description??""}',style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Category:  ${product.category??""}',style: TextStyle(fontWeight: FontWeight.bold)),
          Text('sId:    ${product.sId??""}',style: TextStyle(fontWeight: FontWeight.bold)),

        ],),
      ),
    );
  }
}
