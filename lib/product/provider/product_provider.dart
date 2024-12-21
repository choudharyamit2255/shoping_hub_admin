
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
      AppUtil.showToast(e.toString());
      notifyListeners();
    }
  }
  Future addProduct(Product product) async {
    try {
      bool success = await productService.addProduct(product);
      if (success) {
        notifyListeners();
        AppUtil.showToast('Product has been Added');
      }
    } catch (e) {

      AppUtil.showToast(e.toString());
    }
  }
  Future deleteProduct(String id) async{
    try{
      bool isSuccess = await productService.deleteProduct(id);

      if(isSuccess){
        AppUtil.showToast("Product has been deleted");
      }

    }catch(e){
     AppUtil.showToast(e.toString());
    }
  }
  Future<void> updateProduct(String id, Product updatedProduct) async {
    try {
      bool success = await productService.updateProduct(id,updatedProduct );
      if (success) {
        await fetchProduct();
        AppUtil.showToast('Product has been updated');
      }
    } catch (e) {
      AppUtil.showToast(e.toString());
    }
  }
}

