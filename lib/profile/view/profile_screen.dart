import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_hub_admin/auth/provider/auth_provider.dart';
import 'package:shoping_hub_admin/auth/view/login_screen.dart';
import 'package:shoping_hub_admin/core/app_util.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile Screen"),),
      body: Center(child:
        IconButton(onPressed: (){
          logout(context);

        },icon: Icon(Icons.logout),),),
    );
  }Future logout(BuildContext context)async{
    final provider = Provider.of<AuthProvider>(context,listen: false);
    await provider.logout();


      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
         LoginScreen(),

      ));AppUtil.showToast("logout succesfully");
    }}

