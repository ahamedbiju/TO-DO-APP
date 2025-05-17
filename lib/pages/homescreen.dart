import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_app/data/database.dart';
import 'package:to_do_app/util/dialogbox.dart';
import 'package:to_do_app/util/to_do_tile.dart';

class homescreen extends StatefulWidget {
  homescreen({super.key});

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  final _myBox = Hive.box('mybox');
  ToDoDatabase db = ToDoDatabase();

  void initState() {
    if (_myBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }

    super.initState();
  }

  final _controller = TextEditingController();

  void checkboxchanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void savenew() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void createnewtask() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialogbox(
          controller: _controller,
          onSave: savenew,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
    db.updateDataBase();
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text('TO DOOO', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        foregroundColor: Colors.black87,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createnewtask,
        backgroundColor: Color(0xFF2F2F2F),
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTileS(
            taskname: db.toDoList[index][0],
            taskdone: db.toDoList[index][1],
            onChanged: (value) => checkboxchanged(value, index),
            deletefn: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
