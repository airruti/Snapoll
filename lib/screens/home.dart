import 'package:flutter/material.dart';
import 'package:snapoll/screens/PollCreation.dart';
import 'package:snapoll/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // All app bar widgets are placed in the 'title:' so that I can have complete control over spacing and alignment of each widget
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              iconSize: 30,
              icon: Icon(Icons.arrow_back_rounded, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text('Snapoll', textAlign: TextAlign.center),
              )),
            IconButton(
              iconSize: 45,
              icon: Icon(Icons.add_box_rounded),
              onPressed: () {
                 Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Creator()));
              },
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFE2202C),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFE2202C),
        selectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}
