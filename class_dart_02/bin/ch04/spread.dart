// ... <- 스프레드 연산자 깊은 복사

void main() {
  // 값을 가지고 있는 컬렉션 복사
  var list = [1, 2, 3];
  var newList = [...list];

  newList[0] = 500;
  print(list);
  print(newList);

  print("--------------------------");

  //Map 컬렉션 복사
  var list2 = [
    {"id": 1},
    {"id": 2}
  ];
  // Map 내부 객체를 수정하기 때문에 list2 값도 같이 변경됨
  // var newList2 = [...list2];
  var newList2 = list2.map((i) => {...i}).toList();

  newList2[0]["id"] = 500;

  print(list2);
  print(newList2);

  print(list2.hashCode);
  print(newList2.hashCode);
}
