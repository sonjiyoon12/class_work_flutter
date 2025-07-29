import 'package:flutter/material.dart';

void main() async {
  // dart 비동기 프로그래밍 개념잡기
  // 동기성 : 모든 코드가 순차적으로 진행되는 형태
  // 비동기 : 코드가 순차적으로 진행을 보장할 수 없는 형태

  // 키워드 Future - async / await - 1회성 응답을 돌려받을 때 사용하는 Future

  print('task 1 ... ');

  // 1. 비동기 함수를 필요에 의해서 동기적으로 변경하는 방법
  // await 키워드
  var data1 = await fetchData();
  // 비동기적 방식인데 필요하다면 동기적 방식으로 처리해야 하는 구나!!
  print('task 2 ... ${data1}');

  print('task 3 ...');
}

Future<String> fetchData() {
  return Future.delayed(Duration(seconds: 5), () {
    print('fetchData() 메서드 호출');
    return "2초 Data";
  });
}
