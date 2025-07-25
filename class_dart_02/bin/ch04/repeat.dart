// 반복문 -for map함수 where 연산자
void main() {
  var list = [1, 2, 3, 4];

  for (int i = 0; i < list.length; i++) {
    print(list[i]);
  }

  print("-----------------------");

  var chobab = ["새우초밥", "광어초밥", "연어초밥"];
  var chobabChange = chobab.map((i) => "간장" + i);
  print(chobabChange);

  print("-----------------------");

  var chobab2 = ['새우초밥', '광어초밥', '연어초밥'];
  var chobabchange2 = chobab2.where((i) => i != '광어초밥');
  print(chobabchange2);
}
