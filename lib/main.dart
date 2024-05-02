import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_app/widgets/task_widget.dart';

import 'auth/main_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyDwdyEv7vXhUeP8gHbxVWKXZtDgElDUcF4',
          appId: '1:506821556581:android:ed6eea6e2d4dfd5eaf498c',
          messagingSenderId: 'messagingSenderId',
          projectId: 'to-do-list-app-77995'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TaskWidget(),
    );
  }
}
