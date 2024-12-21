import 'package:flutter/material.dart';
import 'package:shoping_hub_admin/order/model/product_order_item.dart';

class OrderDetailsScreen extends StatelessWidget {
  final List<OrderProductItem> productItemList;

  OrderDetailsScreen({required this.productItemList, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: productItemList.isEmpty
          ? const Center(child: Text('No items in this order'))
          : ListView.builder(
        itemCount: productItemList.length,
        itemBuilder: (context, index) {
          OrderProductItem item = productItemList[index];
          return Card(elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(item.name,style: TextStyle(fontWeight: FontWeight.bold),),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextRow('Product:' ,item.product),
                  buildTextRow('Quantity:', item.quantity.toString()),
                  buildTextRow('Price:', item.price.toStringAsFixed(2)),
                  buildTextRow('Discount:' ,item.discountAmount.toStringAsFixed(2)),
                  buildTextRow('Total:',item.totalPrice.toStringAsFixed(2)),
                ],
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }Widget buildTextRow(String text,String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,   style: const TextStyle(fontWeight: FontWeight.bold)),


        Text(label)
      ],
    );
  }
}
