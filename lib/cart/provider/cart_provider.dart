import 'package:flutter/foundation.dart';
import 'package:shoping_hub_admin/cart/model/cart_model.dart';
import 'package:shoping_hub_admin/cart/model/cart_response.dart';
import 'package:shoping_hub_admin/cart/service/cart_service.dart';
import 'package:shoping_hub_admin/core/app_util.dart';


class CartProvider extends ChangeNotifier {
  CartProvider(this.cartApiService);

  final CartApiService cartApiService;
  bool isLoading = false;
  String? errorMessage;
  CartResponse? cartResponse;


  Future addToCart(CartModel cartModel) async {
    try {
      isLoading = true;
      errorMessage = null;
      // notifyListeners();
      bool isSuccess = await cartApiService.addToCart(cartModel);
      fetchCartItems();
      notifyListeners();
      if (isSuccess) {
        AppUtil.showToast(' Item Added to Cart Successfully');
      }
      isLoading = false;
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      AppUtil.showToast(errorMessage!);
    }
  }

  Future fetchCartItems( ) async {
    try {
      errorMessage = null;
      isLoading = true;
     // notifyListeners();
      cartResponse = await cartApiService.fetchCartItems();
      notifyListeners();
      isLoading = false;
    } catch (e) {
      cartResponse = null;
      isLoading = false;
      errorMessage = e.toString();
      AppUtil.showToast(errorMessage!);
    }
  }

  Future updateCartQuantity(CartModel cartResponse) async {
    try {
      errorMessage = null;
      isLoading = true;
      bool isSuccess = await cartApiService.updateCartQuantity(cartResponse);
      notifyListeners();
      if (isSuccess) {
        AppUtil.showToast(
            ' Cart Item Quantity Updated Successfully');
      }
      isLoading = false;
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      AppUtil.showToast(errorMessage!);
    }
  }

  Future deleteCartItem(String id) async {
    try {
      errorMessage = null;
      isLoading = true;
      notifyListeners();
      bool isSuccess = await cartApiService.deleteCartItem(id);
      if (isSuccess) {
        AppUtil.showToast('Cart Item deleted successfully');
       await fetchCartItems( );
      }
      isLoading = false;
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      AppUtil.showToast(errorMessage!);
    }
  }  Future clearCart() async {
    try {
      errorMessage = null;
      isLoading = true;
      notifyListeners();
        await cartApiService.clearCart();
       await fetchCartItems();
      isLoading = false;
    } catch (e) {
    errorMessage=  e.toString();
    }
    notifyListeners();
  }
}

