


import 'package:flutter/material.dart';
import 'package:shoping_hub_admin/category/model/category_model.dart';
import 'package:shoping_hub_admin/category/service/category_service.dart';
import 'package:shoping_hub_admin/core/app_util.dart';


class CategoryProvider extends ChangeNotifier {

  List<Category> categoryList = [];


  CategoryService categoryService;
  String? errorMessage;

  CategoryProvider(this.categoryService);

  Future fetchCategory() async {
    try {
      categoryList = await categoryService.fetchCategory();
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }Future addCategory(Category category) async {
    try {
      bool success = await categoryService.addCategory(category);
      if (success) {
        notifyListeners();
        AppUtil.showToast('Category Add Successfully');
      }
    } catch (e) {
      notifyListeners();
      AppUtil.showToast(e.toString());
    }
  }

}