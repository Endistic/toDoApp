import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:to_doo_app/model/todo_model.dart';
import 'package:to_doo_app/pages/toDoItem.dart';

class MyToDoList extends StatefulWidget {
  final String title;

  const MyToDoList({super.key, required this.title});

  @override
  State<MyToDoList> createState() => _MyToDoListState();
}

class _MyToDoListState extends State<MyToDoList> {
  final List<Todo> _todos = <Todo>[];
  final TextEditingController _textFieldController = TextEditingController();
  final TextEditingController _textFieldControllerEdit = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: _todos
            .map((Todo todo) => ToDoItem(
                  todo: todo,
                  onTodoChanged: _handleTodoChange,
                  removeTodo: _deleteTodo,
                  editTodo: _displayDialogEdit,
                ))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayDialog(),
        tooltip: 'Add a Todo',
        child: const Icon(Icons.plus_one),
      ),
    );
  }

  void _addTodoItem(String name) {
    setState(() {
      _todos.add(Todo(name: name, complated: false));
      _textFieldController.clear();
    });
  }

  void _handleTodoChange(Todo todo) {
    setState(() {
      todo.complated = !todo.complated!;
    });
  }

  void _deleteTodo(Todo todo) {
    setState(() {
      _todos.removeWhere((element) => element.name == todo.name);
    });
  }

  void _editTodo(Todo todo, String name) {
    setState(() {
      _todos.singleWhere((element) => element.name == todo.name).name =
          _textFieldControllerEdit.text;
      _textFieldControllerEdit.clear();
    });
  }

  Future<void> _displayDialog() async {
    return showDialog<void>(
      context: context,
      builder: ((BuildContext context) {
        return AlertDialog(
          title: const Text('Add to do'),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(helperText: 'Type your todo'),
            autofocus: true,
          ),
          actions: <Widget>[
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _addTodoItem(_textFieldController.text);
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              child: const Text('Add'),
            ),
          ],
        );
      }),
    );
  }

  Future<void> _displayDialogEdit(Todo todo) async {
    return showDialog<void>(
      context: context,
      builder: ((BuildContext context) {
        return AlertDialog(
          title: const Text('Edit to do'),
          content: TextField(
            controller: _textFieldControllerEdit,
            decoration: const InputDecoration(helperText: 'Type your todo'),
            autofocus: true,
          ),
          actions: <Widget>[
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                //_addTodoItem(_textFieldController.text);
                _editTodo(todo, _textFieldControllerEdit.text);
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              child: const Text('Edit'),
            ),
          ],
        );
      }),
    );
  }
}
