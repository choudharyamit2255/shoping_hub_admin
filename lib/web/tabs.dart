import 'package:flutter/material.dart';
import 'package:shoping_hub_admin/profile/view/profile_screen.dart';
import 'package:shoping_hub_admin/web/cart_web.dart';
import 'package:shoping_hub_admin/web/category_web.dart';
import 'package:shoping_hub_admin/web/product_web.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
      Padding(
        padding: const EdgeInsets.only(right: 70),
        child: GestureDetector(onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return ProfileScreen();
          }));
        },
          child: ClipOval(
            child: CircleAvatar(child: Image.network(height: 30,width: 30,
                "https://images.unsplash.com/photo-1484515991647-c5760fcecfc7?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fG1hbnxlbnwwfHwwfHx8MA%3D%3D"),),),
        )
      )
      ],
        title: Text('Shopping'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Product'),
            Tab(text: 'Category'),
            Tab(text: 'Cart'),

          ],
        ),
      ),

      body: TabBarView(
        controller: _tabController,
        children: const [
          ProductWeb(),
          CategoryWeb(),
          CartWeb(),

        ],
      ),


    );
  }
}
