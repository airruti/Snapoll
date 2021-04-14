import 'package:flutter/material.dart';
import 'package:snapoll/screens/PollCreation.dart';
import 'package:snapoll/screens/login_page.dart';
import 'package:snapoll/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CollectionReference pollRef = FirebaseFirestore.instance.collection("polls");

  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  String uid = Uuid().v4();
  int votes = 0;

  List steps = [];


  List<Widget> polls = [PollCard2()];

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
                icon: Icon(Icons.logout, color: Colors.white),
                onPressed: () {
                  auth.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                }),
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
      body: StreamBuilder(
          stream: pollRef.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
                children: snapshot.data.docs.map((document) {
              return Container(
                  child: Center(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        // The spacing between each poll card
                        bottom: 20.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          // Places a border around each poll card
                          color: const Color(0xFFE2202C),
                          width:
                              2.0, // Border outline width, a higher number would make it thicker
                        ),
                        borderRadius: BorderRadius.circular(
                            16.0), // Border radius for each poll, a higher number would make it more round
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            document['Title'],
                            style: TextStyle(
                              // Font color and font weight for the poll title
                              color: const Color(0xFFE2202C),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              // Spacing between the poll title and question in the poll card
                              top: 8.0,
                            ),
                          ),
                          Text(
                            document['Poll Question'],
                            style: TextStyle(
                              // Font color and font weight for the poll title
                              color: const Color(0xFFE2202C),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              // Spacing between the poll title and question in the poll card
                              top: 8.0,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: (){
                              
                              votes++;
                              print(votes);
                            },
                            child: Text(
    //                           for (int i = 0; i < 4; i++) {
    //     steps.add(snapshot.data.documents[index]['steps'][i]['step'])
    //  }
     document['Answers'].toString(),
                              style: TextStyle(
                                // Font color and font weight for the poll title
                                color: const Color(0xFFE2202C),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              // Spacing between the poll title and question in the poll card
                              top: 8.0,
                            ),
                          ),
                          Text(
                            document['Category'],
                            style: TextStyle(
                              // Font color and font weight for the poll title
                              color: const Color(0xFFE2202C),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              // Spacing between the poll title and question in the poll card
                              top: 8.0,
                            ),
                          ),
                          Text(
                            document['Votes'].toString(),
                            style: TextStyle(
                              // Font color and font weight for the poll title
                              color: const Color(0xFFE2202C),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              // Spacing between the poll title and question in the poll card
                              top: 8.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
            }).toList());
          }),
    );
  }
}
