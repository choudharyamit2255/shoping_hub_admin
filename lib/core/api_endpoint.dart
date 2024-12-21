import 'package:shoping_hub_admin/core/app_constant.dart';
import 'package:shoping_hub_admin/core/service/storage_helper.dart';

class ApiEndpoint {
  static const String baseUrl = 'https://e-commerce-server-zc33.onrender.com/api';
  static const String signUpUrl = '$baseUrl/users/register';
  static const String loginUrl = '$baseUrl/users/login';

  static const String product = '$baseUrl/products';

  static  String deleteProduct(String id){
    return '$baseUrl/products/$id';
  }
  static  String updateProduct(String id){
    return '$baseUrl/products/$id';
  }
  static const String category = '$baseUrl/categories';
  static  String deleteCategory(String id){
    return '$baseUrl/categories/$id';
  }
  static  String updateCategory(String id){
    return '$baseUrl/categories/$id';
  }
  static const String cart = '$baseUrl/cart';
  static const String profile = '$baseUrl/users/profile';
  static const String order = '$baseUrl/orders';
  static  String deleteCartItem(String id) {
    return '$baseUrl/cart/$id';
  }
  static  String orderUpdate(String orderId) {
    return '$baseUrl/orders/$orderId';
  }
  static Future<Map<String,String>>getHeader()async{
    String? token = await StorageHelper.getToken();
    return{
      'Content-Type': 'application/json',
      'Authorization':
      'Bearer $token',
      'x-api-key': AppConstant.apiKey

    };
  }
}