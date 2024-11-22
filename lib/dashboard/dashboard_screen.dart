
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_hub_admin/cart/view/cart_screen.dart';
import 'package:shoping_hub_admin/category/view/category_screen.dart';
import 'package:shoping_hub_admin/dashboard/provider/dashboard_provider.dart';
import 'package:shoping_hub_admin/product/view/product_screen.dart';
import 'package:shoping_hub_admin/profile/view/profile_screen.dart';




class DashboardScreen extends StatelessWidget {
  final List<Widget> screens = [
    const ProductScreen(),
    const CategoryScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DashboardProvider>(
        builder: (context, dashboardProvider, child) {
          return screens[dashboardProvider.currentIndex];
        },
      ),
      bottomNavigationBar: Consumer<DashboardProvider>(
        builder: (context, dashboardProvider, child) {
          return BottomNavigationBar(
            currentIndex: dashboardProvider.currentIndex,
            onTap: (index) {
              dashboardProvider.updateIndex(index);
            },
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_bag), label: 'Product'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: 'Category'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart), label: 'Cart'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ],
          );
        },
      ),
    );
  }
}