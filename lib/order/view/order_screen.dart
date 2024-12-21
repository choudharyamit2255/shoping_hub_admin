import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_hub_admin/order/model/order_model.dart';
import 'package:shoping_hub_admin/order/model/order_status.dart';
import 'package:shoping_hub_admin/order/provider/order_provider.dart';
import 'package:shoping_hub_admin/order/view/order_details_screen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  List<String?> selectedOrderStatusList = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<OrderProvider>(context, listen: false).fetchOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: Consumer<OrderProvider>(
        builder: (context, orderProvider, child) {
          if (orderProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }



          if (selectedOrderStatusList.isEmpty) {
            selectedOrderStatusList = List.generate(
                orderProvider.orderList.length,
                    (index) => orderProvider.orderList[index].orderStatus);
          }

          return ListView.builder(
            itemCount: orderProvider.orderList.length,
            itemBuilder: (context, index) {
              Order order = orderProvider.orderList[index];

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text('Order ${order.orderNumber}',style:TextStyle(fontWeight: FontWeight.bold) ,),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      buildTextRow('Items:', order.items.length.toString()),
                      buildTextRow('created:', order.createdAt),
                      DropdownButton(
                        value: selectedOrderStatusList[index],
                        items: orderStatusList.map((item) {
                          return DropdownMenuItem(
                            child: Text(item),
                            value: item,
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            selectedOrderStatusList[index] = value;
                          });
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return OrderDetailsScreen(
                                  productItemList: order.items,
                                );
                              },
                            ),
                          );
                        },
                        child: const Text("View Details"),
                      ),
                    ],
                  ),
                ),
              );
            },
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
