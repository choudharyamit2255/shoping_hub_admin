import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:shoping_hub_admin/category/model/category_model.dart';
import 'package:shoping_hub_admin/core/api_endpoint.dart';
import 'package:shoping_hub_admin/core/app_constant.dart';
import 'package:shoping_hub_admin/core/service/storage_helper.dart';


class CategoryService {
  Future<List<Category>> fetchCategory() async {
    String url = ApiEndpoint.getCategory;
    final response = await http.get(Uri.parse(url),
        headers: {'x-api-key': AppConstant.apiKey});
    if(response.statusCode==200){

      final maplist = jsonDecode(response.body);
      List<Category> categoryList = [];
      for (int a=0;a<maplist.length;a++){
        final map = maplist[a];
        Category category = Category.fromJson(map);
        categoryList.add(category);
      }
      return categoryList;
    }else{
      throw 'No Available Category';
    }
  } Future<bool> addCategory(Category category) async {
    String? token = await StorageHelper.getToken();
    if (token == null) {
      throw 'Token is null';
    }
    String url = ApiEndpoint.addCategory;
    String jsoncategory = jsonEncode(category.toJson());
    final response =
    await http.post(Uri.parse(url), body: jsoncategory, headers: {
      'Content-Type': 'application/json',
      'Authorization':
      'Bearer $token',
      'x-api-key': AppConstant.apiKey
    });
    if (response.statusCode == 201) {
      return true;
    } else {
      throw 'Something Went Wrong';
    }
  }

}
