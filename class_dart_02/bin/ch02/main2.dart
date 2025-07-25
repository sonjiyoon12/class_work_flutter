import 'dog.dart';

// 생성자
void main() {
  Dog d1 = Dog();
  Dog d2 = Dog();

  // Person p1 = Person('홍길동', 100);
  Person p2 = Person(money: 500, name: '홍길동');
}

class Person {
  String? name;
  int? money;

  // dart 에서는 생성자 오버로딩을 지원하지 않습니다.
  // Person(this.name, this.money);
  // Person(this.name);
  // 선택적 매개변수를 활용해서 생성자 오버로딩을 선언할 필요가 없다.
  Person({this.name, this.money});
}
