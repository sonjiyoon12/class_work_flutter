import 'package:flutter/material.dart'; // 모바일로 인식 하려면 선언
import 'package:http/http.dart' as http;

void main() async {
  fetchTodoList();
}

// https://jsonplaceholder.typicode.com/todos/1
// Future (응답 또는 에러 반환)

Future<http.Response> fetchTodo() async {
  const String url = "http://jsonplaceholder.typicode.com/todos/10";
  http.Response response = await http.get(Uri.parse(url));
  print('->>>>> response: ${response} <<<<<--');
  return response;
}

// http://jsonplaceholder.typicode.com/todos
Future<http.Response> fetchTodoList() async {
  const url = "http://jsonplaceholder.typicode.com/todos/1";
  http.Response response = await http.get(Uri.parse(url));
  print('출력1 : ${response.statusCode}');
  print('출력2 : ${response.headers}');
  print('출력3 : ${response.body}');
  return response;
}
