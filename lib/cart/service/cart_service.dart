import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shoping_hub_admin/cart/model/cart_model.dart';
import 'package:shoping_hub_admin/cart/model/cart_response.dart';
import 'package:shoping_hub_admin/core/api_endpoint.dart';



class CartApiService {
  Future<bool> addToCart(CartModel cartModel) async {
    final header = await ApiEndpoint.getHeader();
    String url = ApiEndpoint.cart;
    Response response = await http
        .post(Uri.parse(url),
        body: jsonEncode(cartModel.toJson()), headers: header
    );
    if (response.statusCode == 201) {
      return true;
    }
    throw 'Unable to add cart item';
  }

  Future<CartResponse> fetchCartItems() async {
    final header = await ApiEndpoint.getHeader();
    String url = ApiEndpoint.cart;
    Response response = await http.get(Uri.parse(url), headers: header);
    if (response.statusCode == 200) {
      String body = response.body;
      final decode = jsonDecode(body);
      return CartResponse.fromJson(decode);
    } else {
      throw 'Cart is empty';
    }
  }

  Future<bool> updateCartQuantity(CartModel cartModel) async {
    final header = await ApiEndpoint.getHeader();
    String url = ApiEndpoint.cart;
    Response response = await http
        .put(Uri.parse(url), body: jsonEncode(cartModel.toJson()), headers: header);
    if (response.statusCode == 200) {
      return true;
    }
    throw ' Unable to Update Cart item Quantity';
  }

  Future<bool> deleteCartItem(String id) async {
    final header = await ApiEndpoint.getHeader();
    String url = ApiEndpoint.deleteCartItem(id);
    Response response = await http.delete(Uri.parse(url),
        headers: header
    );
    if (response.statusCode == 200) {
      return true;
    }
    throw 'Unable to Delete Cart Item';
  }
  Future<bool> clearCart() async {
    final header = await ApiEndpoint.getHeader();
    String url = ApiEndpoint.cart;
    final response = await http.delete(Uri.parse(url),
        headers: header
    );
    if (response.statusCode == 200) {
      return true;
    }
    throw 'Unable to clear Cart Items';
  }
}