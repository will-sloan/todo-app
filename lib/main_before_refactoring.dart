import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /*
  Leading button adds the tiles number to button State.
  buttonState stores all the buttons that have been pressed.
  if its in buttonState then it gets a check, it gets a box otherwise.
  */
  void updateButton(tileNumber) {
    setState(() {
      buttonState[tileNumber] = (buttonState[tileNumber] == 0) ? 1 : 0;
    });
  }

  void removeButton(tileNumber) {
    setState(() {
      buttonState.remove(tileNumber);
      //buttonState[tileNumber] = 2;
    });
  }
  var buttonState = Map();
  // var buttonState = bs();
  // int counter = 10;
  // static Map bs() {
  //   var bsMap = Map();
  //   for (int numTiles = 0; numTiles <= 10; ++numTiles) {
  //     bsMap[numTiles] = 0;
  //   }
  //   ;
  //   return bsMap;
  // }

  ListTile tasks(tileNumber) {
    return buttonState[tileNumber] == 0
        ? ListTile(
            leading: FlatButton(
              onPressed: () {
                updateButton(tileNumber);
              },
              child: Icon(Icons.crop_square),
            ), //Icons.done once clicked
            title: Text("$tileNumber Tasks Demo"),
            trailing: FlatButton(
                onPressed: () => {removeButton(tileNumber)},
                child: Icon(Icons.cancel)))
        : ListTile(
            leading: FlatButton(
              onPressed: () {
                updateButton(tileNumber);
              },
              child: Icon(
                Icons.check,
              ),
            ), //Icons.done once clicked
            title: Text("$tileNumber Tasks Demo",
                style: TextStyle(color: Colors.grey)),
            trailing: FlatButton(
                onPressed: () => {removeButton(tileNumber)},
                child: Icon(Icons.cancel)));
  }

  final addTODOController = TextEditingController();


  @override
  void dispose() {
    addTODOController.dispose();
    super.dispose();
  }

  void addTask(name){
    setState(() {
      buttonState[name] = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Stores all the TO-DO items, temperary since it is used to make 10 Tiles
    print(buttonState);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            child: ListTile(
              title: Text(
                "TODO List",
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.left,
              ),
              trailing: FlatButton(
                child: Icon(Icons.add),
                onPressed: () => {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Enter TODO Item"),
                        content: TextField(
                          decoration: InputDecoration(labelText: "TODO Item"),
                          controller: addTODOController,
                          onSubmitted: (text) {
                            //print();
                            addTask(text);
                            Navigator.of(context).pop();},
                        ),
                        // actions: [
                        //   FlatButton(
                        //       child: Text("Add"),
                        //       onPressed: () {
                        //         print("Adding to buttonState, $addTODOController.value.text");
                        //         buttonState['$addTODOController.value.text'] = 0;
                        //         //addTODOController.dispose();
                        //         Navigator.pop(context);
                        //         //addTODOController.value.text;
                        //       }),
                        //   FlatButton(
                        //       child: Text("Cancel"),
                        //       onPressed: () => {Navigator.pop(context)}),
                        //],
                      );
                    },
                  ),
                  //addTask()
                },
              ),

            ),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            margin: EdgeInsets.fromLTRB(15, 40, 15, 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[100],
                boxShadow: [BoxShadow(blurRadius: 0.01)]),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(blurRadius: 0.01)]),
                child: ListView.builder(
                  itemCount: buttonState.length,
                  itemBuilder: (BuildContext context, int index) {
                    // print(
                    //     "Item Builder Button State: $buttonState, index of $index");

                    //
                    return tasks(buttonState.keys.elementAt(index));
                  },
                  // children: <Widget>[
                  //   //buttonState.map( (k,v) => tasks(v)).toList(),
                  //   //for (var item in buttonState.keys.where((k) => buttonState[k] != 2)) tasks(item)
                  //   for (var item in buttonState.keys) tasks(item)
                  // ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
