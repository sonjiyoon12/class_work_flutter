void main() {
  // cascade 연산자.
  // 코드 한 줄로 객체를 변수로 넘겨주면서 객체가 가진 함수를 호출할 수 있는
  // 유용한 표기법이다.

  Chef c1 = Chef('승민군')..cook(); // cascade 연산자
  // c1.cook();
}

class Chef {
  String name;

  Chef(this.name); // 생성자

  void cook() {
    print('요리를 시작합니다');
  }
}
