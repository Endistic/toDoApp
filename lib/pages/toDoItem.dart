import 'package:flutter/material.dart';
import 'package:to_doo_app/model/todo_model.dart';

class ToDoItem extends StatelessWidget {
  ToDoItem(
      {required this.todo,
      required this.onTodoChanged,
      required this.removeTodo,
      required this.editTodo})
      : super(key: ObjectKey(todo));

  final Todo todo;
  final void Function(Todo todo) onTodoChanged;
  final void Function(Todo todo) removeTodo;
  final Future<void> Function(Todo todo) editTodo;
  TextStyle? _getTestStyle(bool checked) {
    if (!checked) return null;

    return const TextStyle(
        color: Colors.black54, decoration: TextDecoration.lineThrough);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTodoChanged(todo);
      },
      leading: Checkbox(
        checkColor: Colors.greenAccent,
        activeColor: Colors.red,
        value: todo.complated,
        onChanged: (value) {
          onTodoChanged(todo);
        },
      ),
      title: Row(
        children: <Widget>[
          Expanded(
              child: Text(
            todo.name!,
            style: _getTestStyle(todo.complated!),
          )),
           IconButton(
            onPressed: () {
              editTodo(todo);
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.blue,
            ),
            alignment: Alignment.centerRight,
            iconSize: 30,
          ),
          IconButton(
            onPressed: () {
              removeTodo(todo);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            alignment: Alignment.centerRight,
            iconSize: 30,
          )
        ],
      ),
    );
  }
}
