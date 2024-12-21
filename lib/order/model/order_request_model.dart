


import 'package:shoping_hub_admin/order/model/product_order_item.dart';
import 'package:shoping_hub_admin/profile/model/shipping_address.dart';

class OrderRequestModel {
  List<OrderProductItem> items;
  ShippingAddress shippingAddress;

  OrderRequestModel({
    required this.items,
    required this.shippingAddress,
  });

  factory OrderRequestModel.fromJson(Map<String, dynamic> json) {
    return OrderRequestModel(
      items: (json['items'] as List)
          .map((item) => OrderProductItem.fromJson(item))
          .toList(),
      shippingAddress: ShippingAddress.fromJson(json['shippingAddress']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'shippingAddress': shippingAddress.toJson(),
    };
  }
}