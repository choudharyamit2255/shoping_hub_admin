import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shoping_hub_admin/core/api_endpoint.dart';
import 'package:shoping_hub_admin/order/model/order_request_model.dart';
import 'package:shoping_hub_admin/order/model/order_response_model.dart';
import 'package:shoping_hub_admin/order/model/order_update_request.dart';


class OrderService {
  Future orderPlace(OrderRequestModel orderRequestModel)async{
    final header = await ApiEndpoint.getHeader();
    Uri uri = Uri.parse(ApiEndpoint.order);
    final json = orderRequestModel.toJson();
    final jsonStr = jsonEncode(json);
    final response = await http.post(uri,headers: header,body: jsonStr);
    if(response.statusCode == 201){
      return true;
    }else{
      throw 'Unable to place order';
    }
  }
  Future <OrderResponse>fetchOrders()async{
    final header = await ApiEndpoint.getHeader();
    Uri uri = Uri.parse(ApiEndpoint.order);

    final response = await http.get(uri,headers: header);
    if(response.statusCode == 200){
      final body = response.body;
      final json = jsonDecode(body);
      OrderResponse orderResponse = OrderResponse.fromJson(json);
      return orderResponse;

    }else{
      throw 'Unable to fetch order';
    }
  }

  Future <bool> updateOrderStatus(UpdateOrderStatusRequest updateOrderStatusRequest)async{
    final header = await ApiEndpoint.getHeader();
    Uri uri = Uri.parse(ApiEndpoint.orderUpdate(updateOrderStatusRequest.orderId));
  final jsonStr = jsonEncode(updateOrderStatusRequest.toJson());
    final response = await http.put(uri,headers: header,body: jsonStr);
    if(response.statusCode == 200){
      return true;

    }else{
      throw 'Unable to fetch order';
    }
  }

  }

