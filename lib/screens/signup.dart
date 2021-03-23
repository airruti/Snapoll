import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class SignUp extends StatelessWidget {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  final auth = FirebaseAuth.instance;
  final fireStoreInstance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
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
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter username';
                  }
                  return null;
                }),
            //email address
            TextFormField(
                decoration: InputDecoration(
                  labelText: "Email",
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter email address';
                  } else if (!value.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                }),
            //password
            TextFormField(
                decoration: InputDecoration(
                  labelText: "Password",
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter password';
                  } else if (value.length < 8) {
                    return 'Please enter a valid password';
                  }
                  return null;
                }),
            //confirm password
            TextFormField(
                decoration: InputDecoration(
                  labelText: "Confirm",
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter password';
                  } else if (value.length < 8) {
                    return 'Please enter a valid password';
                  }
                  return null;
                }),
            ElevatedButton(
              child: Text("Create account"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed))
                      return Colors.red;
                    return Colors.red;
                  },
                ),
              ),
              onPressed: () {
                firebaseSignUp();
              },
            )
          ],
        ),
      ),
    );
  }
  void firebaseSignUp() {
    if (password.value == confirmPassword.value) {
      auth
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text)
          .then((result) {
        fireStoreInstance.collection("userIds").doc(result.user.uid).set({
          "UserID": Uuid().v4(),
        }).then((value) {
          fireStoreInstance.collection("users").doc(result.user.uid).set({
            "Username": username.text,
            "Email": email.text,
          });
        });
      }).catchError(
        (err) {
          //IF EMAIL EXISTS CATCH THE ERROR TAKE TO VERIFY EMAIL
          print(err.code);
          switch (err.code) {
            // case 'email-already-in-use':
            //   Navigator.push(
            //     context,
            //     PageTransition(
            //       child: VerifyEmail(
            //         userType: "Professional",
            //       ),
            //       type: PageTransitionType.rightToLeft,
            //       duration: Duration(milliseconds: 500),
            //     ),
            //   );
            //break;
            default:
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    contentTextStyle: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    titleTextStyle: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    title: Text(
                      "Error",
                    ),
                    content: Text(err.message),
                    actions: [
                      TextButton(
                        child: Text("Ok",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                },
              );
          }
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          contentTextStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          titleTextStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          title: new Text("Error"),
          content: new Text("Passwords must match"),
          actions: <Widget>[
            TextButton(
              child: Text('Ok',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
    }
  }
}
