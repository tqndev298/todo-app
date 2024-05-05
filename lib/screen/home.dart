import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todo_app/data/firestore.dart';
import 'package:todo_app/screen/add_note_screen.dart';
import 'package:todo_app/widgets/task_widget.dart';

import '../widgets/stream_note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

bool show = true;

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Visibility(
        visible: show,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddNoteScreen()));
          },
          backgroundColor: Colors.green,
          child: Icon(
            Icons.add,
            size: 30,
          ),
        ),
      ),
      body: SafeArea(
          child: NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                if (notification.direction == ScrollDirection.forward) {
                  setState(() {
                    show = true;
                  });
                }
                if (notification.direction == ScrollDirection.reverse) {
                  setState(() {
                    show = false;
                  });
                }
                return true;
              },
              child: Column(
                children: [
                  StreamNote(false),
                  Text(
                    'isDone',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.bold),
                  ),
                  StreamNote(true),
                ],
              ))),
    );
  }
}
