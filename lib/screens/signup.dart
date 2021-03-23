import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatelessWidget {
  String _emailField, _passwordField;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        elevation: 1.0,
        title: Text("Create a Snapoll account!"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          children: [
            //username
            TextFormField(
              decoration: InputDecoration(
                labelText: "Username",
              ),
            ),
            //email address
            TextFormField(
              decoration: InputDecoration(
                labelText: "Email",
              ),
            ),
            //password
            TextFormField(
              decoration: InputDecoration(
                labelText: "Password",
              ),
            ),
            //confirm password
            TextFormField(
              decoration: InputDecoration(
                labelText: "Confirm",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
