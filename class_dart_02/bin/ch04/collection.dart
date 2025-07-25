import 'dart:math';

// 컬렉션- 리스트 맵 셋
void main() {
  // List - 순서 있음
  List<int> nums = [1, 2, 3, 4];

  // var nums = [1, 2, 3, 4];

  print(nums[0]);
  print(nums[1]);
  print(nums[2]);
  print(nums[3]);

  print("-------------------------------");

  //Map
  Map<String, dynamic> user = {"id": 1, "username": "cos"};

  print(user["id"]);
  print(user["username"]);
  print("-------------------------------");

  //Set 중복허용 하지 않음, 순서 없음
  Set<int> lotto = {};

  Random r = Random();
  lotto.add(r.nextInt(45) + 1);
  lotto.add(r.nextInt(45) + 1);
  lotto.add(r.nextInt(45) + 1);
  lotto.add(r.nextInt(45) + 1);
  lotto.add(r.nextInt(45) + 1);
  lotto.add(r.nextInt(45) + 1);

  print(lotto);

  List<int> lottoList = lotto.toList();
  lottoList.sort();
  print(lottoList);
}
