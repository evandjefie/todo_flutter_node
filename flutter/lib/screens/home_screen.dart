import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../widgets/todo_popup.dart';
import '../widgets/todo_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Todo> todos = []; // Liste des todos

  void _addTodoToList(Todo todo) {
    setState(() {
      todos.add(todo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDoVoice App'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return TodoPopup(
                onTodoAdd: _addTodoToList,
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
      body: TodoList(),
    );
  }
}
