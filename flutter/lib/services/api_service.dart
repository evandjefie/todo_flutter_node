import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/todo.dart';

class APIService {
  static const String baseURL = 'http://localhost:5000'; // Remplace avec l'adresse de ton API

  Future<Todo> createTodo(Todo todo) async {
    // String jsonTodo = todo.tojson();
    // String jsonTodo = json.encode(todo);
    final response = await http.post(
      // Uri.parse('http://localhost:5000/todo'),
      Uri.parse("$baseURL/todo"),
      // headers: {'content-type': 'application/json'},
      // headers: {'Content-Type': 'application/json'},
      body: todo.tojson(),
      // body: jsonEncode(todo.toJson()),
    );
    
    if (response.statusCode == 200) {
      // return json.decode(jsonTodo);
      return Todo.fromjson(todo.tojson());
      // return Todo.fromjson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create todo');
    }
  }

  Future<List<Todo>> getAllTodos() async {
    final response = await http.get(Uri.parse('$baseURL/todos'));

    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      // return list.map((e) => null)
      // return list.map((mode) => json.decode(todo)).toList();
      // return list.map((model) => {}).toList();
      return list.map((e) => Todo.fromjson(e)).toList();
    } else {
      throw Exception('Failed to load todos');
    }
  }

  // Ajoute les autres méthodes pour les autres opérations CRUD (delete, update, getTodo)
}
