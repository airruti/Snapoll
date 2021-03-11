import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snapoll/screens/signup.dart';
import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _emailField, _passwordField;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        elevation: 1.0,
        title: Text("Sign in to Snapoll!"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "email",
                ),
                onChanged: (value) {
                  setState(() {
                    _emailField = value.trim();
                  });
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "password",
                ),
                onChanged: (value) {
                  setState(() {
                    _passwordField = value.trim();
                  });
                },
              ),
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: ElevatedButton(
                    child: Text("Login"),
                    onPressed: () async {
                      auth.signInWithEmailAndPassword(email: _emailField, password: _passwordField);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: ElevatedButton(
                    child: Text("Create Account"),
                    onPressed: () async {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignUp()));
                      //auth.createUserWithEmailAndPassword(email: _emailField, password: _passwordField);
                    },
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 30),
              child: ElevatedButton(
                child: Text("continue as guest"),
                onPressed: () async {
                  dynamic result = await auth.signInAnonymously();
                  if (result == null) {
                    print("error signing in");
                  } else {
                    print("signed in");
                    print(result);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
