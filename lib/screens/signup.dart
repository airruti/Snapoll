import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              //username
              TextFormField(
                  controller: username,
                  decoration: InputDecoration(
                    labelText: "Username",
                  ),
                  validator: (value) {
                    if (value.length == 0) {
                      return 'Enter a username';
                    } else
                    return null;
                  }),
              //email address
              TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    labelText: "Email",
                  ),
                  validator: (value) {
                    if (value.length == 0) {
                      return 'Enter an email address';
                    } else
                    return null;
                  }),
              //password
              TextFormField(
                  controller: password,
                  decoration: InputDecoration(
                    labelText: "Password",
                  ),
                  validator: (value) {
                    if (value.length == 0) {
                      return 'Password cannot be empty';
                    } else
                    return null;
                  }),
              //confirm password
              TextFormField(
                  controller: confirmPassword,
                  decoration: InputDecoration(
                    labelText: "Confirm password",
                  ),
                  validator: (value) {
                    if (value.length == 0) {
                      return 'Confirm password cannot be empty';
                    } else
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
                  if (_formKey.currentState.validate()) {
                    firebaseSignUp();
                  }
                },
              )
            ],
          ),
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
          "User ID": Uuid().v4(),
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

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }
}
