import 'package:flutter/foundation.dart';
import 'package:shoping_hub_admin/core/app_util.dart';
import 'package:shoping_hub_admin/product/model/product_model.dart';
import 'package:shoping_hub_admin/product/service/product_service.dart';



class ProductProvider extends ChangeNotifier{

  List<Product> productList = [];
  ProductService productService;
  String? errorMessage;
  ProductProvider(this.productService);
  Future fetchProduct()async{
    try{
      productList = await productService.fetchProducts();
      notifyListeners();
    }catch(e){
      errorMessage = e.toString();
      notifyListeners();
    }
  }
  Future addProduct(Product product) async {
    try {
      bool success = await productService.addProduct(product);
      if (success) {
        notifyListeners();
        AppUtil.showToast('Product Add Successfully');
      }
    } catch (e) {
      notifyListeners();
      AppUtil.showToast(e.toString());
    }
  }

}

