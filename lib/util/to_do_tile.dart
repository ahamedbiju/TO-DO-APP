import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTileS extends StatelessWidget {
  final String taskname;
  final bool taskdone;
  final Function(bool?)? onChanged;
  Function(BuildContext)? deletefn;
  ToDoTileS({
    super.key,
    required this.taskname,
    required this.taskdone,
    required this.onChanged,
    required this.deletefn,
  }) {
    // TODO: implement ToDoTileS
    //throw UnimplementedError();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deletefn,
              icon: Icons.delete,
              backgroundColor: Color(0xFFB00020),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Checkbox(
                value: taskdone,
                onChanged: onChanged,
                activeColor: Colors.black,
              ),
              Text(
                taskname,
                style: TextStyle(
                  decoration:
                      taskdone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
