


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
  }

  Future addCategory(Category category) async {
    try {
      bool success = await categoryService.addCategory(category);
      if (success) {
        notifyListeners();
        AppUtil.showToast('Category has been added');
      }
    } catch (e) {
      notifyListeners();
      AppUtil.showToast(e.toString());
    }
  }


  Future deleteCategory(String id) async{
    try{
      bool isSuccess = await categoryService.deleteCategory(id);
      if(isSuccess){
        AppUtil.showToast("Category has been deleted");
      }

    }catch(e){
      AppUtil.showToast(e.toString());
    }
  } Future<void> updateCategory(String id, Category updatedCategory) async {
    try {
      bool success = await categoryService.updateCategory(id,updatedCategory );
      if (success) {

        await fetchCategory();
        AppUtil.showToast('Category has been updated');
      }
    } catch (e) {
      AppUtil.showToast(e.toString());
    }
  }
}