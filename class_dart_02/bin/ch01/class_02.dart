void main() {
  //Dart - 익명 함수

  // 1 단계 - 이름이 없는 함수 (선언을 하더 라도 사용할 방법이 없다)
  // --- dart 언어는 익명 함수를 변수에 담을 수 있다.
  var a = (int number) {
    return 100 + number;
  };

  print(a); // 함수 자체를 출력하는 문법
  print(a(10)); // 함수를 호출 즉, 실행 시키는 방법은 괄호 사용(...)
  print(a.runtimeType);

  // dart 언어는 일급 객체를 지원 합니다.
  // 자바 에서 함수를 변수에 담을 수 있나? no
  // 매개 변수 안에 함수를 선언할 수 있다.

  // 2단계
  int Function(int) b = (int number1) {
    return number1;
  };

  int Function(int, int) c = (int number1, int number2) {
    return number1 * number2;
  };

  // 리턴 타입 생략 가능해 dart는 !!
  Function(int, int, double) d = (int number1, int number2, double d3) {
    return number1 * number2 * d3;
  };

  var e = (int number1, int number2, double d3, double d4) {
    return number1 * number2 * d3 * d4;
  };

  // 3단계
  // dart 는 파라미터 타입을 생략시킬 수도 있다.
  Function sub = (a, b) {
    return a * b;
  };

  var sum1 = sub(1.1, 2);
  print(sum1);

  // 4 단계
  var multiply = (a, b) {
    return a * b;
  };

  print(multiply(2, 8));

  // 5단계 함수에 인수값으로 함수를 전달 받을 수 있다.
  performOperation(10, 5, add);
  performOperation(10, 5, multiply2);
}

/**
   * (매개변수) {
      // 수행구문
      }
   */

// 전달될 함수들 선언
int add(int a, int b) {
  return a + b;
}

int multiply2(int a, int b) {
  return a * b;
}

// 매개 변수로 함수를 받는 함수를 선언
void performOperation(int a, int b, int Function(int, int) operation) {
  print(operation(a, b));
}
