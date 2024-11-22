import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:shoping_hub_admin/core/api_endpoint.dart';
import 'package:shoping_hub_admin/core/app_constant.dart';
import 'package:shoping_hub_admin/core/service/storage_helper.dart';
import 'package:shoping_hub_admin/product/model/product_model.dart';


class ProductService {
  Future<List<Product>> fetchProducts() async {
    String url = ApiEndpoint.getProduct;
    final response = await http.get(Uri.parse(url),
        headers: {'x-api-key': AppConstant.apiKey});
    if (response.statusCode == 200) {
      final maplist = jsonDecode(response.body);
      List<Product> productList = [];
      for (int a = 0; a < maplist.length; a++) {
        final map = maplist[a];
        Product product = Product.fromJson(map);
        productList.add(product);
      }
      return productList;
    } else {
      throw 'Unavailable product';
    }
  }


  Future<bool> addProduct(Product product) async {
    String? token = await StorageHelper.getToken();
    if (token == null) {
      throw 'Null Token';
    }
    String url = ApiEndpoint.addProduct;
    String jsonProduct = jsonEncode(product.toJson());
    final response =
    await http.post(Uri.parse(url), body: jsonProduct, headers: {
      'Content-Type': 'application/json',
      'Authorization':
      'Bearer $token',
      'x-api-key': AppConstant.apiKey
    });
    if (response.statusCode == 201) {
      return true;
    } else {
      throw 'SomeThing went Wrong';
    }
  }

}