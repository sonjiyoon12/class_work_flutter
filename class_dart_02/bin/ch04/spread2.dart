void main() {
  // 컬렉션에 데이터 추가
  var list = [1, 2, 3];
  var newList = [...list, 4];

  print(list);
  print(newList);

  // 컬렉션에 데이터 수정
  var users = [
    {"id": 1, "username": "cos", "password": 1234},
    {"id": 2, "username": "ssar", "password": 5678}
  ];

  // 이름 변경 위해 다른 값 다 적어줘야해서 수정 갯수 많아지면 불편
  // var newUser = users.map(
  //         (user) => user["id"] == 2 ? {"id" : 2, "username": "love", "password" : 5678} : user
  // ).toList();

  // 스프레드 연산자 사용으로 간결해짐
  var newUser = users
      .map((user) => user["id"] == 2 ? {...user, "username": "love"} : user)
      .toList();

  print(users);
  print(newUser);
}
