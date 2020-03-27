// TODO:
// - SQL Databasing? Nah Do Read and writing. SQLite is better for more data.
// - Changing Name does not affect its spot

import 'dart:collection';

import 'package:flutter/material.dart';
import 'tileModels.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(title: 'TODO Task App'),
      debugShowCheckedModeBanner: false,
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

  var buttonState = Map();

  final addTODOController = TextEditingController();

  void updateButton(tileName) {
    setState(() {
      buttonState[tileName] = (buttonState[tileName] == 0) ? 1 : 0;
      //updateOrder();
    });
  }

  void removeButton(tileName) {
    setState(() {
      buttonState.remove(tileName);
      //updateOrder();
    });
  }

  @override
  void dispose() {
    addTODOController.dispose();
    super.dispose();
  }

  void addTask(name) {
    setState(() {
      while (buttonState.containsKey(name)) {
        //print("Name $name");
        name = name + " Take 2";
      }
      buttonState[name] = 0;
      //updateOrder();
    });
  }

  void editTask(name, newname) {
    setState(() {
      //print("EditTask $name ${buttonState[name]} $newname ${buttonState[newname]}");
      while (buttonState.containsKey(newname)) {
        //print("Name $name");
        newname = newname + " Take 2";
      }
      buttonState[newname] = buttonState[name];
      buttonState.remove(name);
      //updateOrder();
      //print("EditTask $name ${buttonState[name]} $newname ${buttonState[newname]}");
    });
  }

  void updateOrder() {
    setState(() {
      // print("updating order potentially");
      // bS = SplayTreeMap.from(buttonState, (a, b) => (buttonState[a]).compareTo((buttonState[b])));
      // print("BS in update $bS");
      // print("In Button Sort $buttonState");
      buttonState = sortButtonMap(buttonState);
      //print("In Button Sort $buttonState \n\n\n\n");
    });
  }

  LinkedHashMap sortButtonMap(LinkedHashMap map) {
    List mapKeys = map.keys.toList(growable: false);
    mapKeys.sort((k1, k2) => map[k1] - map[k2]);
    LinkedHashMap resMap = new LinkedHashMap();
    mapKeys.forEach((k1) {
      resMap[k1] = map[k1];
    });
    return resMap;
  }

  @override
  Widget build(BuildContext context) {
    //bS = SplayTreeMap.from(buttonState, (a, b) => (buttonState[a]).compareTo((buttonState[b])));
    //print("BS $bS \n ButtonState $buttonState");
    // Stores all the TO-DO items, temperary since it is used to make 10 Tiles
    //print(buttonState);
    buttonState['TITLEBARNAME_DONOTUSE'] = -1;
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
                trailing: popUpAddTask(context, addTODOController, addTask)),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.fromLTRB(15, 40, 15, 10),
            decoration: generalBox(),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(15),
              decoration: generalBox(),
              child: ListView.builder(
                itemCount: buttonState.length,
                itemBuilder: (BuildContext context, int index) {
                  //print("In Builder $buttonState ");
                  // Since buttonState stores with task_name : state, the length has to grab the first item from the keys
                  // rather then just index the Map like buttonState[index] (this does not work)!
                  var keyValue = buttonState.keys.elementAt(index);
                  //return tasks(keyValue, buttonState[keyValue]);
                  return (buttonState[keyValue] == -1)
                      ? titleTodoTile(updateOrder)
                      : TodoTile(
                          updateButton: updateButton,
                          removeButton: removeButton,
                          editTask: editTask,
                          tileName: keyValue,
                          tileValue: buttonState[keyValue],
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

ListTile titleTodoTile(updateOrder) {
  return ListTile(
    //leading: Text("Status"),
    // title: Text(, textAlign: TextAlign.center, style: TextStyle(fontSize: 24)),
    trailing: FlatButton(
      child: Icon(Icons.refresh),
      onPressed: updateOrder,
    ),
  );
}

BoxDecoration generalBox() {
  return BoxDecoration(
      color: Colors.grey[100],
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(blurRadius: 0.01)]);
}

FlatButton popUpAddTask(context, addTODOController, addTask) {
  return FlatButton(
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
                addTask(text);
                addTODOController.clear();
                Navigator.of(context).pop();
              },
            ),
          );
        },
      ),
    },
  );
}
