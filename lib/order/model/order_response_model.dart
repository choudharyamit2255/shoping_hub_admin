
import 'package:shoping_hub_admin/order/model/order_model.dart';

class OrderResponse {
  List<Order>? orders;

  OrderResponse({this.orders});

  OrderResponse.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = <Order>[];
      json['orders'].forEach((v) {
        orders!.add( Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}






