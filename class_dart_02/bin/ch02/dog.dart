class Dog {
  String name = "Toto";
  int age = 10;
  String color = "white";
  int thirsty = 100;

  // 행위 를 통해 변경
  void drinkWater(Water w) {
    w.drink();
    thirsty = thirsty - 50;
  }
}

class Water {
  double liter = 2.0;

  void drink() {
    liter = liter - 0.5;
  }
}

// 코드의 진입점
void main() {
  // 객체란 상태와 행위를 함께 지니며 행위를 통해서 상태를 변경한다.

  Dog dog1 = Dog();
  Water water = Water();

  dog1.drinkWater(water);
}
