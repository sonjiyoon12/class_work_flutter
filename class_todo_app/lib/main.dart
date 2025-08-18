import 'package:flutter/material.dart';

/**
 * 모노리스 구조로 코드를 작성해 보자.
 */
void main() => runApp(const TodoApp());

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  // UI 로직: 사용자가 입력하는 텍스트를 관리하는 컨트롤러
  final TextEditingController _controller = TextEditingController();
  // 데이터 저장할 변수
  List<String> todoList = [];

  // 비즈니스 로직 : 할 일을 추가하는 기능
  void addTodo() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        todoList.add(_controller.text);
        _controller.clear();
      });
    }
  }

  // 도전 과제 - 삭제 기능 구현 하기
  void deleteTodo(int index) {
    // 자료구조에 접근해서 해당하는 데이터를 삭제해주면 된다.
    if (_controller.text.isEmpty) {
      setState(() {
        todoList.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('todo app'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                // textField, 아이콘
                SizedBox(
                  width: 330,
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: '작업을 입력하세요',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: addTodo,
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(todoList[index]),
                    trailing: IconButton(
                      onPressed: () {
                        deleteTodo(index);
                      },
                      icon: Icon(
                        Icons.delete_forever,
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
