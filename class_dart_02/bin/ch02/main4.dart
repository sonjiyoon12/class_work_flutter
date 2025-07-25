void main() {
  // null 병합 연산자(null 대체 연산자)
  // 1. null에 안전한 객체의 사용 - 가능한 속성 접근
  String? maybeName;
  int length = maybeName?.length ?? 0;
  print('length : ${length}');

  // 2. null 에 안전한 객체 메서드 접근
  String? name = getName();

  // 문자열 값을 무조건 소문자로 변형을 하고 싶은 상황..
  String resultName = name?.toLowerCase() ?? "HONG".toLowerCase();
  print('resultName : ${resultName}');

  String displayName = name ?? 'Unknown';
  // if(displayName != null){
  //   print(displayName);
  // }
  print(displayName);

  // null 억제 연산자 또는 null assert 연산자 --> !
  // String? name2 = null;
  String? name2 = '홍';
  // 강제적으로 null 값이 아니다 라고 명시할 대 사용할 수 있음
  // 단 null 오류 조심
  String name3 = name2!;
}

// 함수
// 스트링 데이터 타입이 아니라 스트링 널어블 타입입니다!!!
String? getName() {
  return null;
}
