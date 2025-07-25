void main() {
  // Dart 함수
  // 문제1 -원의 면적을 구하는 함수를 설계하세요
  // 반지름 값은 5.0
  print(calculateCircleArea(5.0));

  // 문제2 - 직사각형 면적을 구하는 함수를 설계하세요
  // 가로 길이 3.0, 세로 길이 4.0
  print(calculateRectangleArea(3.0, 4.0));
}

// 문제 1번 함수를 완성 하시오.
double calculateCircleArea(double r) {
  // 반지름 * 반지름 * 3.14
  return r * r * 3.14;
}

// 문제 2번 함수를 완성 하시오.
double calculateRectangleArea(double x, double y) {
  // 가로 * 세로
  return x * y;
}
