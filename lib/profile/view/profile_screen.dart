import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_hub_admin/auth/provider/auth_provider.dart';
import 'package:shoping_hub_admin/auth/view/login_screen.dart';
import 'package:shoping_hub_admin/core/app_util.dart';
import 'package:shoping_hub_admin/order/view/order_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({ super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile Screen"),),
      body: Column(
        children: [
          Row(
            children: [
              IconButton(onPressed: (){
                logout(context);

              },icon: const Icon(Icons.logout),),Text("logout"),
            ],
          ),
          Row(
            children: [
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return OrderScreen( );
                }));

              },icon: const Icon(Icons.shopping_bag_outlined),),Text("orders")
            ],
          ),

        ],
      ),
    );
  }

Future logout(BuildContext context)async{
    final provider = Provider.of<AuthProvider>(context,listen: false);
    await provider.logout();

   if(context.mounted) {
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
         LoginScreen(),

     ));
     AppUtil.showToast("logout Successfully");
   }    }}

