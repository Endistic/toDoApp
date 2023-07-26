import 'package:flutter/material.dart';
import 'package:to_doo_app/pages/toDoList.dart';


class ToDoMain extends StatelessWidget {
  const ToDoMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My ToDo',
      theme: ThemeData(primaryColor: Colors.black),
      home: const MyToDoList(title: "My List",),
    );
  }
}