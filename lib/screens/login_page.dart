import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snapoll/screens/signup.dart';
import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
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
                  controller: email,
                  decoration: InputDecoration(
                    labelText: "email",
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter email address';
                    } else if (!value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  }),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "password",
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter password';
                    } else if (value.length < 8) {
                      return 'Please enter a valid password';
                    }
                    return null;
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: Text("Login"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Colors.red;
                        return Colors.red; // Use the component's default.
                      },
                    ),
                  ),
                  onPressed: () async {
                    try {
                      await auth.signInWithEmailAndPassword(
                          email: email.text, password: password.text);
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => Home()));
                    } catch (e) {
                      return (e.message);
                    }
                  },
                ),
                ElevatedButton(
                  child: Text("Create Account"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Colors.red;
                        return Colors.red; // Use the component's default.
                      },
                    ),
                  ),
                  onPressed: () async {
                    Navigator.of(context)
                        .pushReplacement(
                            MaterialPageRoute(builder: (context) => SignUp()));
                  },
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                child: Text("continue as guest"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return Colors.red;
                      return Colors.red; // Use the component's default.
                    },
                  ),
                ),
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
