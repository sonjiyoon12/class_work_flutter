class MyClass {

  late String name;

  // MyClass(this.name);

  MyClass() {
    // 서버에서 요청한 값을 받아서 클래스를 만들어야 될 때
    // 통신을 통해 초기값을 받아야 하는 경우 많이 사용한다. late 키워드
    name = "홍길동";
  }
}