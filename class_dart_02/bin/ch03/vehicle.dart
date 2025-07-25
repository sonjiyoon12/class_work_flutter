// 추상 클래스 - 단 하나의 추상메서드가 있으면
abstract class Vehicle {
  String brand;

  Vehicle(this.brand);

  // 추상 메서드
  void start(); // 강제성을 제공해야 할 때 (상속 할 때)

  // 일반 메서드
  void displayInfo() {
    print("브랜드명 : ${brand}");
  }
}

class Car extends Vehicle {
  Car(String brand) : super(brand);

  // 주석 + 힌트
  // @override
  void start() {
    print("${brand} 자동차가 시동을 겁니다");
  }
}

class Flyable {
  void fly() {}
}

class Swinmmable {
  void swim() {}
}

class Duck implements Flyable, Swinmmable {
  @override
  void fly() {
    print("오리 날다 떨어짐");
  }

  @override
  void swim() {
    print('오리 수영하다 잠듬');
  }
}
