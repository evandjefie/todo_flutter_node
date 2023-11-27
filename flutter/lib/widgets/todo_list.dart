import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../services/api_service.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final APIService _apiService = APIService();
  late Future<List<Todo>> _todosFuture;

  @override
  void initState() {
    super.initState();
    _fetchTodos();
  }

  void _fetchTodos() {
    _todosFuture = _apiService.getAllTodos();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Todo>>(
      future: _todosFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Todo>? todos = snapshot.data;
          return ListView.builder(
            itemCount: todos?.length ?? 0,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(todos![index].title),
                subtitle: Text(todos[index].description),
              );
            },
          );
        }
      },
    );
  }
}
