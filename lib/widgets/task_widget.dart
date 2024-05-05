import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/constant/colors.dart';
import 'package:todo_app/data/firestore.dart';
import 'package:todo_app/screen/edit_note_screen.dart';

import '../model/notes_model.dart';

class TaskWidget extends StatefulWidget {
  final Note _note;
  const TaskWidget(this._note, {super.key});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

bool isDone = false;

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    bool isDone = widget._note.isDone;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: double.infinity,
      height: 130,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 2))
          ]),
      child: Row(
        children: [
          Container(
            height: 130,
            width: 100,
            decoration: BoxDecoration(color: Colors.amber),
            child: Text(widget._note.image.toString()),
          ),
          SizedBox(
            width: 25,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget._note.title,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Checkbox(
                      value: isDone,
                      onChanged: (value) {
                        setState(() {
                          isDone = !isDone;
                        });
                        Firestore_Datasource().isDone(widget._note.id, isDone);
                      },
                    )
                  ],
                ),
                // SizedBox(
                //   height: 5,
                // ),
                Text(
                  widget._note.subtitle,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade400),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        width: 90,
                        height: 28,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(18)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 20,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget._note.time,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditNoteScreen(widget._note),
                            )),
                        child: Container(
                          width: 90,
                          height: 28,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(18)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Edit',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
