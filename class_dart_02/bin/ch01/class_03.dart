void main() {
  // 화살표 함수 dart 2.7 이후 부터 제공
  // 화살표 함수는 간단한 함수를 더 간결하게 표현할 수 있는 표현식입니다.

  List<String> footballplayers = ['메시', '손흥민', '김민재', '이강인'];

  footballplayers.forEach((e) {
    print(e);
  });
  print("---------------------------");
  footballplayers.forEach((e) => print('축구선수 : ${e}'));
}

/**
 * int add(int a, int b){
 *     return a + b;
 * }
 *
 * int addArrow(int a, int b) => a + b;
 */

// 1. 기존 함수 정의
int add1(int n1, int n2) {
  return n1 + n2;
}

int sub1(int n1, int n2) {
  return n1 - n2;
}

double div1(int n1, int n2) {
  return n1 / n2;
}

// 2. 위 함수를 람다식으로 변경해 보자.
int add(int n1, int n2) => n1 + n2;

int sub(int n1, int n2) => n1 - n2;

double div(int n1, int n2) => n1 / n2;

// 람다식의 단점
// 아래 함수 처럼 분기 및 복잡한 함수는 람다식을 사용하기 어렵다.
// 이럴 경우에는 원래 하듯이 함수 body 애 정의하는것이 타당 하다.
int subsract(int a, int b) {
  if (a > b) {
    return a - b;
  } else {
    return b - a;
  }
}
