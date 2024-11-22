import 'package:flutter/cupertino.dart';
import 'package:shoping_hub_admin/core/service/storage_helper.dart';

class SplashProvider extends ChangeNotifier{

  Future<bool> checkLoggedIn()async{
    bool isLoggedIn = false;
    String? token = await StorageHelper.getToken();
    if(token!=null){
      isLoggedIn = true;
    }else{
      isLoggedIn = false;
    }return isLoggedIn;
  }
}