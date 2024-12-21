
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_hub_admin/auth/provider/auth_provider.dart';
import 'package:shoping_hub_admin/auth/provider/splash_provider.dart';
import 'package:shoping_hub_admin/auth/service/auth_service.dart';
import 'package:shoping_hub_admin/auth/view/splash_screen.dart';
import 'package:shoping_hub_admin/cart/provider/cart_provider.dart';
import 'package:shoping_hub_admin/cart/service/cart_service.dart';
import 'package:shoping_hub_admin/category/provider/category_provider.dart';
import 'package:shoping_hub_admin/category/service/category_service.dart';
import 'package:shoping_hub_admin/dashboard/provider/dashboard_provider.dart';
import 'package:shoping_hub_admin/order/provider/order_provider.dart';
import 'package:shoping_hub_admin/order/service/order_api_service.dart';
import 'package:shoping_hub_admin/product/provider/product_provider.dart';
import 'package:shoping_hub_admin/product/service/product_service.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (build)=>AuthProvider(AuthService())),
        ChangeNotifierProvider(create: (context){
          return DashboardProvider();}),
        ChangeNotifierProvider(create: (context){
          return ProductProvider(ProductService());}),
        ChangeNotifierProvider(create: (context){
          return CategoryProvider(CategoryService());}),
        ChangeNotifierProvider(create: (context){
          return SplashProvider();}),
        ChangeNotifierProvider(create: (context){
          return CartProvider(CartApiService());}),
        ChangeNotifierProvider(create: (context){
          return OrderProvider(OrderService());}),

      ],
      child: MaterialApp(debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  SplashScreen()
      ),
    );
  }
}
