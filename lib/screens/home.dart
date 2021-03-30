import 'package:flutter/material.dart';
import 'package:snapoll/screens/PollCreation.dart';
import 'package:snapoll/widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
              onPressed: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => creator()));
              },
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFE2202C),
      ),
      body: SafeArea(
          child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                        bottom: 32.0,
                      )),
                      Expanded(
                          child: ListView(children: [
                        PollCard(
                            title: 'Best Tarantino Film',
                            question: 'What\'s the best Tarantino film?',
                            category: 'Movies'),
                        PollCard(
                          title: 'Best Guard Dog',
                          question:
                              'Which dog can protect me the best from burglars?',
                          category: 'Pets',
                          votes: 123,
                        ),
                        PollCard(title: 'Favorite Kanye West Song', question: 'What\'s your favorite Kanye song?', category: 'Music', votes: 99,),
                      ]))
                    ],
                  )
                ],
              ))),
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
