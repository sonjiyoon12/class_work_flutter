void main() {
  // dart 상수
  // 상수 - 한번 할당된 값이 변경 되지 않는 변수
  // 키워드 const, final

  // final - 런 타임 상수(Run-time Constant)
  final int n1 = 10;
  // 프로그램이 실행되는 도중에 값이 결정되며, 이후 에는 변경 불가능
  // n1 = 100; // 컴파일 시점에 오류 확인

  // const - 컴파일 타입 상수(Compile-time Constant)
  const int n2 = 100;
  // 코드가 컴파일 될 때 값이 확정이되며, 이후에는 변경 불가능
  // n2 = 200;
}
