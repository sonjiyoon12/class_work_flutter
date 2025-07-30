//Todo 데이터를 표현하는 모델 클래스
// Json 문자열을 패키지 dart:convert --> 에서 메서드를 사용 하면 Map 구조로 변경해 줌
import 'dart:convert';

class Todo {
  int? userId;
  int? id;
  String? title;
  bool? completed;

  // 기본 생성자 - 빈 객체 생성용
  Todo();

  // 명명된 생성자 (이름이 있는 생성자)
  // 매개변수에 Map 구조를 받는 파리미터 설계
  // 초기화 이니셜라이저 (:) 사용해서 멤버 변수에 값 할당
  // json = {"a" : true}
  // print(json[a])
  // Array = a[0]
  // a[]
  Todo.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        id = json['id'],
        title = json['title'],
        completed = json['completed'];

  //디버깅용 toString 재정의
  @override
  String toString() {
    return 'Todo{userId: $userId, id: $id, title: $title, completed: $completed}';
  }
}
