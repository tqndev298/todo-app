import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../data/firestore.dart';
import 'task_widget.dart';

class StreamNote extends StatelessWidget {
  bool done;
  StreamNote(this.done, {super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore_Datasource().stream(done),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final noteList = Firestore_Datasource().getNotes(snapshot);
          print(noteList.length);
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final note = noteList[index];
              return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    Firestore_Datasource().deleteNote(note.id);
                  },
                  child: TaskWidget(note));
            },
            itemCount: noteList.length,
          );
        });
  }
}
