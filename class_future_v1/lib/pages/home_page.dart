import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String msg = "메세지 입니다";

  // Future<http.Response> fetchTodo() async {
  //   const String url = "http://jsonplaceholder.typicode.com/todos/10";
  //   http.Response response = await http.get(Uri.parse(url));
  //   print(response.statusCode);
  //   print(response.body);
  //   print(response.headers);
  //   return response;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HTTP 통신"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: 400,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blue,
            ),
            child: Center(
              child: Text(msg),
            ),
          ),
          Center(
            child: InkWell(
              onDoubleTap: () async {
                print("더블 클릭");
                // http.Response res = await fetchTodo();

                const String url =
                    "http://jsonplaceholder.typicode.com/todos/10";
                http.Response response = await http.get(Uri.parse(url));

                setState(() {
                  msg = response.body;
                });
              },
              child: Container(
                alignment: Alignment.center,
                width: 200,
                height: 60,
                child: Text(
                  "Button",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.amber,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
