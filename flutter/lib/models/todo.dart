// class Todo {
//   final String title;
//   final String description;

//   Todo({required this.title, required this.description});
// }

import 'dart:ffi';

class Todo {
  String title;
  String description;
  // Bool completed;

  Todo({
    required this.title,
    required this.description,
    // required this.completed
  });

  Map<String, dynamic> tojson(){
    return {
      'title' : title,
      'description' : description,
      // 'completed' : completed
    };
  }

  factory Todo.fromjson(Map<String, dynamic> json) {
    return Todo(
      title: json['title'],
      description: json['description'],
      // completed: json['completed']
    );
  }

}
