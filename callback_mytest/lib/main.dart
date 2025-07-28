import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ParentsView(),
    );
  }
}

class ParentsView extends StatefulWidget {
  const ParentsView({super.key});

  @override
  State<ParentsView> createState() => _ParentsViewState();
}

class _ParentsViewState extends State<ParentsView> {
  String displayText = "여기는 부모 위젯 영역 이야";

  void handleCallback(String msg) {
    // print("자식 위젯에게서 연락이 왔어!");
    setState(() {
      displayText = "${msg}에게서 연락이 왔어!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(flex: 1, child: Center(child: Text(displayText))),
          Expanded(
              flex: 1,
              child: ChildA(
                onCallback: handleCallback,
              )),
          Expanded(
              flex: 1,
              child: ChildB(
                onCallback: handleCallback,
              )),
        ],
      )),
    );
  }
}

class ChildA extends StatelessWidget {
  final String message = "CHILD A";
  Function(String msg) onCallback;

  ChildA({required this.onCallback, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          onCallback(message);
          // print("childA 위젯에서 이벤트 발생!!");
        },
        child: Container(
          width: double.infinity,
          color: Colors.orange,
          child: Center(
            child: Text('CHILD A'),
          ),
        ),
      ),
    );
  }
}

class ChildB extends StatelessWidget {
  final String message = "CHILD B";
  Function(String msg) onCallback;

  ChildB({required this.onCallback, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          onCallback(message);
          // print("childB 위젯에서 이벤트 발생!");
        },
        child: Container(
          width: double.infinity,
          color: Colors.orange,
          child: Center(child: Text("CHILD B")),
        ),
      ),
    );
  }
}
