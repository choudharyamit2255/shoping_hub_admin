
import 'package:shoping_hub_admin/order/model/order_model.dart';

class OrderList {
  final List<Order> orders;

  OrderList({
    required this.orders,
  });

  factory OrderList.fromJson(Map<String, dynamic> json) {
    return OrderList(
      orders: (json['orders'] as List<dynamic>?)
          ?.map((order) => Order.fromJson(order as Map<String, dynamic>))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orders': orders.map((order) => order.toJson()).toList(),
    };
  }
}