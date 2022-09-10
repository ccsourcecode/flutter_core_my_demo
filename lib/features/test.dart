import 'package:http/http.dart' as http;
import 'dart:convert';

class Todo {
  final String title;
  Todo({required this.title});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      title: json['title'],
    );
  }
}

Future<Todo> fetchTodo(http.Client client) async {
  final response =
      await client.get(Uri.https('https://xxx.com/todos/1', '/users'));

  if (response.statusCode == 200) {
    //請求成功，解析JSON
    return Todo.fromJson(json.decode(response.body));
  } else {
    //請求失敗，拋出異常
    throw Exception('Failed to load post');
  }
}

class Counter {
  int count = 0;
  void increase() => count++;
  void decrease() => count--;
}
