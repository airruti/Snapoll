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
                    Icon(CategoryIcon(category),
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

// Method that returns the appropriate icon for a category

IconData CategoryIcon(String category)
{
  IconData theIcon;
  switch(category)
  {
    case 'Pets':
      theIcon = Icons.pets_rounded;
      break;
    case 'Movies':
      theIcon = Icons.local_movies_rounded;
      break;
    case 'Music':
      theIcon = Icons.music_note_rounded;
      break;
    case 'Fast Food':
      theIcon = Icons.fastfood_rounded;
      break;
    case 'Restaurants':
      theIcon = Icons.restaurant_rounded;
      break;
    case 'Science':
      theIcon = Icons.science_rounded;
      break;
    case 'Fitness':
      theIcon = Icons.fitness_center_rounded;
      break;
    case 'Video Games':
      theIcon = Icons.videogame_asset_rounded;
      break;
    case 'Travel':
      theIcon = Icons.public_off_rounded;
      break;
    case 'Education':
      theIcon = Icons.school_rounded;
      break;
    case 'General':
      theIcon = Icons.chat_rounded;
      break;
    default:
      theIcon = Icons.error_rounded;    
  }

  return theIcon;
}