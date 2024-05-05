import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/notes_model.dart';
import 'package:uuid/uuid.dart';

class Firestore_Datasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> createUser(String email) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .set({"id": _auth.currentUser!.uid, "email": email});
      return true;
    } catch (e) {
      return true;
    }
  }

  Future<bool> addNote(String subtitle, String title, int image) async {
    try {
      var uuid = Uuid().v4();
      DateTime dateTime = new DateTime.now();
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(uuid)
          .set({
        "id": uuid,
        'subtitle': subtitle,
        'title': title,
        'image': image,
        'isDone': false,
        'time': '${dateTime.hour}:${dateTime.minute}'
      });
      return true;
    } catch (e) {
      return true;
    }
  }

  List getNotes(AsyncSnapshot snapshot) {
    try {
      final noteList = snapshot.data!.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Note(
            id: data['id'],
            subtitle: data['subtitle'],
            title: data['title'],
            time: data['time'],
            image: data['image'],
            isDone: data['isDone']);
      }).toList();
      return noteList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Stream<QuerySnapshot> stream(bool isDone) {
    return _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('notes')
        .where('isDone', isEqualTo: isDone)
        .snapshots();
  }

  Future<bool> isDone(
    String uuid,
    bool isDone,
  ) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(uuid)
          .update({
        'isDone': isDone,
      });
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  Future<bool> editNote(
      String uuid, int image, String title, String subtitle) async {
    try {
      DateTime dateTime = new DateTime.now();

      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(uuid)
          .update({
        'title': title,
        'subtitle': subtitle,
        'image': image,
        'time': '${dateTime.hour}:${dateTime.minute}'
      });
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  Future<bool> deleteNote(String uuid) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(uuid)
          .delete();
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }
}
