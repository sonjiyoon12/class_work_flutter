import 'package:class_http/models/Todo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  Todo todo;
  http.Response res = await fetchTodo();
  if (res.statusCode == 200) {
    print("통신 성공");
    print(res.headers.runtimeType);
    print('---------------------------');
    print(res.body.runtimeType);
    print('---------------------------');
    // String 문자열을 Map<String, dynamic> 타입으로 변환 처리
    Map<String, dynamic> jsonMap = json.decode(res.body);
    print(jsonMap.runtimeType);
    print('---------------------------');
    print(jsonMap['userId']);
    print(jsonMap['title']);
    todo = Todo.fromJson(jsonMap);
    // Todo myTodo = new Todo();
    print(todo.toString());
  }
  print(res.statusCode);
}

Future<http.Response> fetchTodo() async {
  String url = "http://jsonplaceholder.typicode.com/todos/1";
  // Future<http.Response> response = http.get(Uri.parse(url));
  http.Response response = await http.get(Uri.parse(url));
  print(response.runtimeType);
  return response;
}
