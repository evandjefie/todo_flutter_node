import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../services/api_service.dart';

class TodoPopup extends StatelessWidget {
  final Function(Todo) onTodoAdd;
  final APIService _apiService = APIService();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  // final controller

  TodoPopup({required this.onTodoAdd});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Nouveau ToDo'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Titre'),
          ),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(labelText: 'Description'),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            Todo newTodo = Todo(
              title: _titleController.text,
              description: _descriptionController.text,
              // completed: false
            );

            try {
              // Appel de la méthode pour créer le Todo via l'API
              Todo createdTodo = await _apiService.createTodo(newTodo);

              // Appel de la fonction de rappel pour ajouter le nouveau Todo
              onTodoAdd(createdTodo);
              Navigator.of(context).pop();
            } catch (e) {
              print('Error creating todo: $e');
              // Gérer l'erreur ici (affichage d'un message, par exemple)
            }
          },
          child: Text('Ajouter'),
        ),
      ],
    );
  }
}
