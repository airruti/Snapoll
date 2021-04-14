import 'package:flutter/material.dart';
import 'package:snapoll/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

// Poll creation screen

class Creator extends StatefulWidget {
  @override
  _CreatorState createState() => _CreatorState();
}

class _CreatorState extends State<Creator> {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  List<DynamicChoice> dynamicList = [];

  List<TextEditingController> choices = [];
  TextEditingController title = TextEditingController();
  TextEditingController question = TextEditingController();
  TextEditingController category = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget dynamicTextField = Flexible(
      flex: 2,
      child: ListView.builder(
        itemCount: dynamicList.length,
        itemBuilder: (_, index) => dynamicList[index],
      ),
    );

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus.unfocus();
        }
      },
      child: Scaffold(
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
                padding: const EdgeInsets.only(right: 46),
                child: Text('Poll Creation', textAlign: TextAlign.center),
              )),
            ],
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFFE2202C),
        ),

        //Adds new Choices
        body: SafeArea(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(4, 0, 4, 4),
              margin: EdgeInsets.only(
                top: 32,
                bottom: 32.0,
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
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                        controller: title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: const Color(0xFFE2202C),
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(labelText: 'Title')),
                    TextField(
                        controller: question,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(labelText: 'Question')),
                    TextField(
                        controller: category,
                        decoration: InputDecoration(
                            labelText: 'Category (Replace with drop down)')),
                    Padding(padding: EdgeInsets.fromLTRB(4, 8, 4, 4)),
                    dynamicTextField,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          child: FittedBox(
                            child: FloatingActionButton(
                                onPressed: addDynamic,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0))),
                                backgroundColor: const Color(0xFFE2202C),
                                child: Icon(Icons.add_rounded, size: 45)),
                          ),
                        ),
                      ],
                    ),
                    RaisedButton(
                      padding: EdgeInsets.all(10),
                      color: Color(0xFFE2202C),
                      textColor: Colors.white,
                      onPressed: () {
                        databasePoll();
                      },
                      child: Text("Create Poll"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ); //End of Scaffold
  }

  databasePoll() {
    final String storage = Uuid().v4();
    db.collection("polls").doc(storage).set(
      {
        "Poll Question": question.text,
        "Answers": test(),
        "Title": title.text,
        "Category": category.text,
        "Votes": 0,
      },
    );
  }

  addDynamic() {
    debugPrint("Add Pressed");
    if (choices.length != 0) {
      choices = [];
      dynamicList = [];
      debugPrint("Add Reset");
    }
    setState(() {});
    if (dynamicList.length >= 6) {
      return;
    }
    dynamicList.add(DynamicChoice());
    debugPrint("Added Field");
  } //Build End

  List<String> test(){
    List<String> choic = [];
    for(int i = 0; i < dynamicList.length; i++){
      choic.add(dynamicList[i].getString());

    }
    return choic;
  }
}

// Dynamic choice widget is made stateful so that a Choice counter can implemented
// class DynamicChoice extends StatefulWidget {
//   @override
//   _DynamicChoiceState createState() => _DynamicChoiceState();
// }

// class _DynamicChoiceState extends State<DynamicChoice> {
//   TextEditingController choices = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.fromLTRB(4, 4, 4, 8),
//       child: TextFormField(
//         controller: choices,
//         autofocus: true,
//         decoration: InputDecoration(
//             // Increment the choice count
//             hintText: 'Choice',
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(8.0)),
//               borderSide: const BorderSide(color: Colors.red),
//             )),
//       ),
//     );
//   }

//   String getString(){
//     return choices.text;
//   }
// }
// 
class DynamicChoice extends StatelessWidget {
  final TextEditingController choices = TextEditingController();
  @override
  Widget build(BuildContext context) {
    
      return Container(
      padding: EdgeInsets.fromLTRB(4, 4, 4, 8),
      child: TextFormField(
        controller: choices,
        autofocus: true,
        decoration: InputDecoration(
            // Increment the choice count
            hintText: 'Choice',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: const BorderSide(color: Colors.red),
            )),
      ),
    );
  }
  String getString(){
    return choices.text;
  }
}
