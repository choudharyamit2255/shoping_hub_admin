import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_hub_admin/auth/provider/splash_provider.dart';
import 'package:shoping_hub_admin/auth/view/login_screen.dart';
import 'package:shoping_hub_admin/dashboard/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    decideScreen();
  }

  Future<void> decideScreen() async {
    SplashProvider splashProvider = Provider.of<SplashProvider>(context, listen: false);
    bool isLoggedIn = await splashProvider.checkLoggedIn();
    if (isLoggedIn) {
      if(mounted){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashboardScreen()));
    }} else {
      if(mounted){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Shopping Hub", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ),
    );
  }
}