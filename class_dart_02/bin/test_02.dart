// 함수
void main() {
  print(addOne(10));
  gugudan(5);
  gugudan(4);
  gugudan(3);
}

int addOne(int n) {
  return n + 1;
}

void gugudan(int num) {
  print("${num}*1 = ${num * 1}");
  print("${num}*2 = ${num * 2}");
  print("${num}*3 = ${num * 3}");
  print("${num}*4 = ${num * 4}");
  print("${num}*5 = ${num * 5}");
  print("${num}*6 = ${num * 6}");
  print("${num}*7 = ${num * 7}");
  print("${num}*8 = ${num * 8}");
  print("${num}*9 = ${num * 9}");

  for (int i = 1; i <= 9; i++) {
    print("${num}*${i} = ${num * i}");
  }
}
