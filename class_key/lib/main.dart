import 'package:class_key/components/custom_container.dart';
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
      home: Scaffold(
        body: MyHomPage(),
      ),
    );
  }
}

class MyHomPage extends StatefulWidget {
  const MyHomPage({super.key});

  @override
  State<MyHomPage> createState() => _MyHomPageState();
}

class _MyHomPageState extends State<MyHomPage> {
  // 자료 구조(메모리에서 데이터를 넣고 빼고 수정..)
  // List, Map, Set
  List<Widget> containers = [
    CustomContainer("1", key: ValueKey(1)),
    CustomContainer("2", key: ValueKey(2)),
    CustomContainer("3", key: ValueKey(3)),
  ];

  // 변수
  Widget extraContainer = const CustomContainer("Extra");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: containers,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (containers.length == 3) {
              containers.insert(0, extraContainer);
            } else if (containers.length == 4) {
              containers.removeAt(0);
            }
          });
        },
        child: Icon(
          Icons.add_box_rounded,
          size: 42,
        ),
      ),
    );
  }
}
