import 'package:flutter/material.dart';
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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppBar(
            title: Text('Snapoll', style: TextStyle(fontSize: 25)),
            toolbarHeight: 80,
            centerTitle: true,
            backgroundColor: const Color(0xFFE2202C),
            titleSpacing: 0,
            actions: [
              IconButton(
                iconSize: 45,
                icon: Icon(Icons.add_box_rounded),
                onPressed: () {},
              ),
            ],
          ),
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
                      )
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          PollCard(),
                          PollCard(title: 'Best Guard Dog', question: 'Which dog can protect me the best from burglars?', category: 'pets, dogs, pitbulls, labrador', votes: 123,),
                        ]
                      )
                    )
                  ],
                )
              ],
            )
          )
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
