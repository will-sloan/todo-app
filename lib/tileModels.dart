import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  final Function updateButton;
  final Function removeButton;
  final Function editTask;
  final int tileValue;
  final tileName;
  TodoTile(
      {this.updateButton,
      this.removeButton,
      this.editTask,
      this.tileValue,
      this.tileName});
  final editContoller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return tileValue == 0
        ? GestureDetector(
            child: ListTile(
                leading: FlatButton(
                  onPressed: () {
                    updateButton(tileName);
                  },
                  child: Icon(Icons.crop_square),
                ), //Icons.done once clicked
                title: Text("$tileName"),
                trailing: FlatButton(
                    onPressed: () => {removeButton(tileName)},
                    child: Icon(Icons.cancel))),
            onDoubleTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Enter TODO Item"),
                    content: TextField(
                      decoration: InputDecoration(labelText: "TODO Item"),
                      controller: editContoller,
                      onSubmitted: (text) {
                        //print("$tileName + $text");
                        //dont put name: tilename newname:text, it messes it up for some reason
                        editTask(tileName, text);
                        //print("Got past");
                        Navigator.of(context).pop();
                      },
                    ),
                  );
                },
              );
            },
          )
        : ListTile(
            leading: FlatButton(
              onPressed: () {
                updateButton(tileName);
              },
              child: Icon(
                Icons.check,
              ),
            ), //Icons.done once clicked
            title: Text("$tileName", style: TextStyle(color: Colors.grey)),
            trailing: FlatButton(
                onPressed: () => {removeButton(tileName)},
                child: Icon(Icons.cancel)));
  }
}
