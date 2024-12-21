import 'package:flutter/cupertino.dart';
import 'package:shoping_hub_admin/core/app_util.dart';
import 'package:shoping_hub_admin/order/model/order_model.dart';
import 'package:shoping_hub_admin/order/model/order_request_model.dart';
import 'package:shoping_hub_admin/order/model/order_response_model.dart';
import 'package:shoping_hub_admin/order/model/order_update_request.dart';
import 'package:shoping_hub_admin/order/service/order_api_service.dart';


class OrderProvider extends ChangeNotifier {
  OrderService orderService;

  OrderProvider(this.orderService);

  bool isLoading = false;
  String? error;

  List<Order> orderList = [];

  Future orderPlace(OrderRequestModel orderRequestModel) async {
    try {
      error = null;
      isLoading = true;
     // notifyListeners();
      bool isSuccess = await orderService.orderPlace(orderRequestModel);
      if (isSuccess) {
        AppUtil.showToast('Order placed successfully');
      } isLoading = false;
    } catch (e) {
      isLoading = false;
      error = e.toString();
    }
    notifyListeners();
  }
  Future fetchOrders() async {
    try {
      error = null;
      isLoading = true;
      notifyListeners();
      OrderResponse orderResponse = await orderService.fetchOrders();
      orderList = orderResponse.orders?? [];
       isLoading = false;
    } catch (e) {
      isLoading = false;
      error = e.toString();
    }
    notifyListeners();
  }
  Future updateOrderStatus(UpdateOrderStatusRequest request) async {
    try {
      error = null;
      isLoading = true;
      notifyListeners();
      bool isSuccess = await orderService.updateOrderStatus(request);
   if(isSuccess){
     AppUtil.showToast("Order status updated successfully");
   }
      isLoading = false;
    } catch (e) {
      isLoading = false;
      error = e.toString();
    }
    notifyListeners();
  }
}