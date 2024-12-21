import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:shoping_hub_admin/core/api_endpoint.dart';
import 'package:shoping_hub_admin/core/app_constant.dart';
import 'package:shoping_hub_admin/product/model/product_model.dart';


class ProductService {

  Future<List<Product>> fetchProducts() async {
    String url = ApiEndpoint.product;
    final response = await http.get(Uri.parse(url),
        headers: {'x-api-key': AppConstant.apiKey});
    if (response.statusCode == 200) {
      final mapList = jsonDecode(response.body);
      List<Product> productList=[];
      for (int a = 0; a < mapList.length; a++) {
        final map = mapList[a];
        Product product = Product.fromJson(map);
        productList.add(product);
      }
      return productList;
    } else {
      throw 'Unavailable product';
    }
  }

  Future<bool> addProduct(Product product) async {
    final header = await ApiEndpoint.getHeader();
    String url = ApiEndpoint.product;
    String jsonProduct = jsonEncode(product.toJson());
    final response =
    await http.post(Uri.parse(url), body: jsonProduct, headers: header);
    if (response.statusCode == 201) {
      return true;
    } else {
      throw ' Product is not being added ${response.body}';
    }
  }
Future<bool> deleteProduct(String id) async {
  String url = ApiEndpoint.deleteProduct(id);
  final header = await ApiEndpoint.getHeader();
  final response = await http.delete(
    Uri.parse(url),
    headers: header,
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    throw ' Product is not being deleted';
  }
}

Future<bool> updateProduct(String id ,Product product) async {
    final header = await ApiEndpoint.getHeader();
    String url = ApiEndpoint.updateProduct(id);
    final response = await http.put(
      Uri.parse(url),body: jsonEncode(product.toJson()),
      headers: header
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw 'Failed to update product';
    }
  }
}