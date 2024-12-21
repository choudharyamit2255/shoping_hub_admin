import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shoping_hub_admin/category/model/category_model.dart';
import 'package:shoping_hub_admin/core/api_endpoint.dart';
import 'package:shoping_hub_admin/core/app_constant.dart';
class CategoryService {
  Future<List<Category>> fetchCategory() async {
    String url = ApiEndpoint.category;
    final response = await http.get(Uri.parse(url),
        headers: {'x-api-key': AppConstant.apiKey});
    if(response.statusCode==200){

      final mapList = jsonDecode(response.body);
      List<Category> categoryList = [];
      for (int a=0;a<mapList.length;a++){
        final map = mapList[a];
        Category category = Category.fromJson(map);
        categoryList.add(category);
      }
      return categoryList;
    }else{
      throw 'No Available Category';
    }
  }
  Future<bool> addCategory(Category category) async {
    String url = ApiEndpoint.category;
    String jsonCategory = jsonEncode(category.toJson());
    final header = await ApiEndpoint.getHeader();
    final response =
    await http.post(Uri.parse(url), body: jsonCategory, headers: header
      );
    if (response.statusCode == 201) {
      return true;
    } else {
      throw 'Your category is not being added';
    }
  }
  Future<bool> deleteCategory(String id) async {
    Uri url = Uri.parse(ApiEndpoint.deleteCategory(id));
    final header = await ApiEndpoint.getHeader();
    Response response = await http.delete(
     url, headers: header
    );
    if (response.statusCode==200) {
      return true;
    }
    else {
      throw 'Your category is not being deleted';
    }
  }
  Future<bool> updateCategory(String id, Category category) async {
    String url = ApiEndpoint.updateCategory(id);
    final header = await ApiEndpoint.getHeader();

    final response = await http.put(
      Uri.parse(url),
      body: jsonEncode(category.toJson()),
      headers: header
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw 'Your category is not being updated';
    }
  }
}
