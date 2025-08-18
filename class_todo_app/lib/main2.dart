import 'package:class_todo_app/todo_view_model.dart';
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
  final todoViewModel = TodoViewModel();

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
                  onPressed: () {
                    // 기존에 만들었던 index + 1
                    String lastIndex =
                        (todoViewModel.todoList.length + 1).toString();
                    todoViewModel.addTodo(lastIndex, _controller.text);
                    _controller.clear();
                    setState(() {});
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: todoViewModel.todoList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      // list.get(index).title <-- java // todoList[index]
                      todoViewModel.todoList[index].title,
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        todoViewModel.removeTodo(index);
                        setState(() {});
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
