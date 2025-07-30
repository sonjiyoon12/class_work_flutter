import 'package:class_http/models/Todo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  http.Response res = await fetchTodo();
  List<dynamic> jsonList = json.decode(res.body);
  print(jsonList.runtimeType);
  print(jsonList[1]['title']);
  print(jsonList[1]['id']);
}

Future<http.Response> fetchTodo() async {
  String url = "http://jsonplaceholder.typicode.com/todos";
  // Future<http.Response> response = http.get(Uri.parse(url));
  http.Response response = await http.get(Uri.parse(url));
  print(response.runtimeType);
  return response;
}
