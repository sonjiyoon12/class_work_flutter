// ViewModel 클래스
// 뷰에 상태와 UI 관련 로직을 관리
import 'package:class_todo_app/todo.dart';

class TodoViewModel {
  // 화면과 관련된 데이터를 관리
  List<Todo> todoList = [];

  // 할 일 추가 메서드
  void addTodo(String index, String title) {
    final newTodo = Todo(
      id: index,
      title: title,
    );
    todoList.add(newTodo);
  }

  // 할일 삭제 메서드
  void removeTodo(int index) {
    todoList.removeAt(index);
  }
}
