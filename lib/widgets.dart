import 'package:flutter/material.dart';

class PollCard extends StatelessWidget {
  final String title;
  final String question;
  final String category;
  final int votes;
  PollCard({this.title, this.question, this.category, this.votes});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(4, 16, 4, 4),
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
            title ??
                "UNNAMED POLL", // If there is no provided title, it will default to UNNAMED POLL
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
              question ??
                  "NO QUESTION ADDED", // If there is no provided question, the text will default to NO QUESTION ADDED
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
              )),
          Padding(
            // Padding between question and the bottom row
            padding: EdgeInsets.only(
              top: 8.0,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // Left container
                padding: EdgeInsets.symmetric(
                  vertical: 2.0,
                  horizontal: 4.0,
                ),
                child: Row(
                  children: [
                    Icon(Icons.pets_rounded,
                        color: const Color(0xFFE2202C)),
                    Padding(padding: EdgeInsets.only(left: 4.0)),
                    Text(
                      category ??
                        'NO CATEGORY',
                      style: TextStyle(
                        color: const Color(0xFFE2202C),
                        fontWeight: FontWeight.bold,
                        ),
                    ),
                  ],
                ),
              ),
              Container(
                // Right container (contains a row with person icon and number of votes)
                decoration: BoxDecoration(
                  color: const Color(0xFFE2202C),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 2.0,
                  horizontal: 10.0,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    Text(
                      votes.toString(),
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
