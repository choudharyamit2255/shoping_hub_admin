

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoping_hub_admin/auth/models/user_admin.dart';
import 'package:shoping_hub_admin/auth/service/auth_service.dart';
import 'package:shoping_hub_admin/core/app_util.dart';
import 'package:shoping_hub_admin/core/service/storage_helper.dart';


class AuthProvider extends ChangeNotifier {
  final AuthService authSrvc;

  AuthProvider(this.authSrvc);
  bool isLoading = false;

  Future<String?> login(UserAdmin user) async {
    try {
      isLoading = true;
      notifyListeners();
      String token = await authSrvc.login(user);
     await StorageHelper.saveToken(token);
      isLoading = false;

      notifyListeners();
      return token;
    } catch (e) {
      isLoading = false;
      AppUtil.showToast( e.toString());
      return null;
    }
  }

  Future<String> signUp(UserAdmin user) async {
    try {
      String response = await authSrvc.signUp(user);
      notifyListeners();
      return response;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return "Sign up failed";
    }
  } Future  logout()async{
    try{
    await StorageHelper.clearToken();
    authSrvc.logout();

    notifyListeners();
  }catch(e){
      (e.toString());
    }
  }
}