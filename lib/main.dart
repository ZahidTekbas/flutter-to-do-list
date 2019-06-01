import 'package:flutter/material.dart';
import 'package:MyApp/todolist.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'To-Do List App',
      home: new TodoList(),
    );
  }
}

