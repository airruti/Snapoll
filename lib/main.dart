import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:snapoll/screens/home.dart';
import 'auth_wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

//void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: AuthenticationWrapper(),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}