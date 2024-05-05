import 'package:flutter/material.dart';
import 'package:todo_app/constant/colors.dart';
import 'package:todo_app/data/firestore.dart';
import 'package:todo_app/model/notes_model.dart';

class EditNoteScreen extends StatefulWidget {
  final Note _note;
  const EditNoteScreen(this._note, {super.key});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();

  TextEditingController? title;
  TextEditingController? subtitle;
  int indexx = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = TextEditingController(text: widget._note.title);
    subtitle = TextEditingController(text: widget._note.subtitle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColors,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextField(
              controller: title,
              focusNode: _focusNode1,
              style: TextStyle(fontSize: 18, color: Colors.black),
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  hintText: 'Title',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Color(0xffc5c5c5c), width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.green, width: 2))),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextField(
              maxLines: 5,
              controller: subtitle,
              focusNode: _focusNode2,
              style: TextStyle(fontSize: 18, color: Colors.black),
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  hintText: 'Subtitle',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Color(0xffc5c5c5c), width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.green, width: 2))),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 180,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      indexx = index;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            width: 2,
                            color:
                                indexx == index ? Colors.green : Colors.grey)),
                    width: 140,
                    margin: EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text(index.toString())],
                    ),
                  ),
                );
              },
              itemCount: 6,
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Firestore_Datasource().editNote(
                        widget._note.id, indexx, title!.text, subtitle!.text);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: Size(170, 48)),
                  child: Text(
                    'Edit task',
                    style: TextStyle(color: Colors.white),
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, minimumSize: Size(170, 48)),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          )
        ],
      )),
    );
  }
}
