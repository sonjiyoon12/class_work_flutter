import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

void main() async {
  http.Response res = await fetchPost();
  List<dynamic> jsonList = json.decode(res.body);
  print(jsonList.runtimeType);
  print(jsonList[0]['title']);
  print(jsonList[0]['userId']);
}

Future<http.Response> fetchPost() async {
  String url = "http://jsonplaceholder.typicode.com/posts";
  http.Response response = await http.get(Uri.parse(url));
  print(response.runtimeType);
  return response;
}
