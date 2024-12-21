

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shoping_hub_admin/auth/models/user_admin.dart';

import 'package:shoping_hub_admin/auth/provider/auth_provider.dart';
import 'package:shoping_hub_admin/core/app_util.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signup() async {
    if (_formKey.currentState!.validate()) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      try {
        final user = User(
          email: usernameController.text,
          password: passwordController.text,
        );

        String responseMsg = await authProvider.signUp(user);


        Fluttertoast.showToast(msg: responseMsg);

        if (responseMsg == "Account Created Successfully") {

          Navigator.pop(context);
        }
      } catch (e) {
        AppUtil.showToast(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return

    Scaffold(

        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Padding(
                padding: const EdgeInsets.only(bottom: 48.0),
                child: Text("SignUp..",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 55),),
              ),
                TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(filled: true,
                    hintText: 'enter your Username..',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(filled: true,
                    hintText: 'enter your password..',suffixIcon: Icon(Icons.remove_red_eye),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  onPressed: signup,
                  child: Text('Sign Up',style: TextStyle(color: Colors.blue[900]),),
                ),
              ],
            ),
          ),
        ),
     );

  }
}