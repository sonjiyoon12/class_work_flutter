import 'dart:convert';

import 'package:class_http/models/Post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async {
  http.Response res = await fetchPost();
  if (res.statusCode == 200) {
    print("통신 성공");
    print(res.headers.runtimeType);
    print('------------------------');
    print(res.body.runtimeType);
    print('-----------------------');
    Map<String, dynamic> map = json.decode(res.body);
    print(map.runtimeType);
    print('-----------------------');
    print(map['userId']);
    print(map['title']);
    Post post = Post.fromJson(map);
    print(post.toString());
  }
}

Future<http.Response> fetchPost() async {
  String url = "http://jsonplaceholder.typicode.com/posts/1";
  http.Response response = await http.get(Uri.parse(url));
  print(response.runtimeType);
  return response;
}
