import 'package:flutter/material.dart';
import 'package:snapoll/screens/home.dart';

class creator extends StatefulWidget{

  @override
  _creatorState createState() => _creatorState();

}

class _creatorState extends State<creator>{

  List<dynamicChoice> dynamicList = [];

  List<String> choices = [];
  String title;
  String tags;

  addDynamic(){
    debugPrint("Add Pressed");
    if(choices.length != 0){
      choices = [];
      dynamicList = [];
      debugPrint("Add Reset");
    }
    setState((){});
    if(dynamicList.length >= 6){
      return;
    }
    dynamicList.add(new dynamicChoice());
    debugPrint("Added Field");
  }

  @override 
  Widget build(BuildContext context){
      Widget dynamicTextField = new Flexible(
    flex: 2,
    child: new ListView.builder(
      itemCount: dynamicList.length,
      itemBuilder: (_, index) => dynamicList[index],
    ),
);



      return new Scaffold(
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
                icon: Icon(Icons.home),
                onPressed: () async { Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));},
              ),
            ],
          ),
        ),
        
          //Adds new Choices
          body: new Container(
            child: new Column(
          children: [
            
            new TextFormField(
              decoration: InputDecoration(
                labelText: 'Title'
              )
            ) ,
            new TextFormField(
              decoration: InputDecoration(
                labelText: 'Question'
              )
            ) ,
            new TextFormField(
              decoration: InputDecoration(
                labelText: 'Tags'
              )
            ) ,
            dynamicTextField
            ],
        ),

          ),
          floatingActionButton: new FloatingActionButton(
            onPressed: addDynamic,
            child: new Icon(Icons.add)
          ),
      );//End of Scaffold

  }//Build End
}

class dynamicChoice extends StatelessWidget{

  TextEditingController choice = new TextEditingController();

  @override 
  Widget build(BuildContext context){
    return Container(
      width: 300,
      padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
      child: new TextFormField(
        controller: choice,
        decoration: const InputDecoration(
          labelText: 'Choice',
          border: OutlineInputBorder()
        ),
      ),
    );
  }//Build End
}