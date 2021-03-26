import 'package:flutter/material.dart';
import 'package:snapoll/authentication/authenticate.dart';
import 'package:snapoll/screens/home.dart';

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return auth or home
    return Authenticate();
  }
}