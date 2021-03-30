import 'package:cloud_firestore/cloud_firestore.dart';
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
        backgroundColor: const Color(0xFFE2202C),
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
                  controller: password,
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
                          return const Color(0xFFE2202C);
                        return const Color(0xFFE2202C); // Use the component's default.
                      },
                    ),
                  ),
                  onPressed: () {
                    firebaseSignIn();
                  },
                ),
                ElevatedButton(
                  child: Text("Create Account"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return const Color(0xFFE2202C);
                        return const Color(0xFFE2202C); // Use the component's default.
                      },
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context,
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
                        return const Color(0xFFE2202C);
                      return const Color(0xFFE2202C); // Use the component's default.
                    },
                  ),
                ),
                onPressed: () async {
                  dynamic result = await auth.signInAnonymously();
                  if (result == null) {
                    print("error signing in");
                  } else {
                    
                    // Changed this to push so the user proceeds to the next screen, tapping the back button returns to the sign in page.
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
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

  Future<dynamic> getData(dynamic result, String type) async {
    final DocumentReference document =
        FirebaseFirestore.instance.collection("userIds").doc(result.user.uid);
    await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
      Map<String, dynamic> data = snapshot.data();
      if (data[type] != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                contentTextStyle:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                titleTextStyle:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                title: Text(
                  "Error",
                ),
                content: Text("Account Does Not Exist"),
                actions: [
                  TextButton(
                    child: Text("Ok",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      }
    });
  }

  void firebaseSignIn() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.text, password: password.text)
        .then((result) {
      getData(result, "User ID");
    }).catchError((err) {
      print(err.message);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              contentTextStyle:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              titleTextStyle:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              title: Text(
                "Error",
              ),
              content: Text(err.message),
              actions: [
                TextButton(
                  child: Text("Ok",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
  }
}
