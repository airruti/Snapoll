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
  String uuid = Uuid().v4();
  int votes = 0;

  List steps = [];

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
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          width: double.infinity,
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
                              Padding(padding: EdgeInsets.only(top: 10)),
                              Text(
                                document['Title'],
                                style: TextStyle(
                                  // Font color and font weight for the poll title
                                  color: const Color(0xFFE2202C),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
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
                              ConstrainedBox(
                                constraints: BoxConstraints.tightFor(
                                    height: 35, width: 300),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFFE2202C),
                                  ),
                                  onPressed: () {
                                    votes++;
                                    pollRef.doc(uuid).update({'Votes': votes});
                                  },
                                  child: Text(
                                    document['Answers'][0],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  // Spacing between the poll title and question in the poll card
                                  top: 8.0,
                                ),
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints.tightFor(
                                    height: 35, width: 300),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFFE2202C),
                                  ),
                                  onPressed: () {
                                    votes++;
                                    pollRef.doc(uuid).update({'Votes': votes});
                                  },
                                  child: Text(
                                    document['Answers'][1],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  // Spacing between the poll title and question in the poll card
                                  top: 8.0,
                                ),
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints.tightFor(
                                    height: 35, width: 300),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFFE2202C),
                                  ),
                                  onPressed: () {
                                    votes++;
                                    pollRef.doc(uuid).update({'Votes': votes});
                                  },
                                  child: Text(
                                    document['Answers'][2],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  // Spacing between the poll title and question in the poll card
                                  top: 8.0,
                                ),
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints.tightFor(
                                    height: 35, width: 300),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFFE2202C),
                                  ),
                                  onPressed: () {
                                    votes++;
                                    pollRef.doc(uuid).update({'Votes': votes});
                                  },
                                  child: Text(
                                    document['Answers'][3],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  // Spacing between the poll title and question in the poll card
                                  top: 8.0,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 2.0,
                                      horizontal: 10.0,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          categoryIcon(document['Category']),
                                          color: const Color(0xFFE2202C),
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.only(left: 4.0)),
                                        Text(
                                          document['Category'],
                                          style: TextStyle(
                                            // Font color and font weight for the poll title
                                            color: const Color(0xFFE2202C),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE2202C),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 2.0,
                                      horizontal: 10.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.person,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          document['Votes'].toString(),
                                          style: TextStyle(
                                            // Font color and font weight for the poll title
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
