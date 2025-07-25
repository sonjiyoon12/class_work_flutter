// 상속
void main() {
  //Animal("호랑이");
  //Animal(name: "호랑이");
  Dog d1 = Dog("호랑이강아지", "고양이사료");
  print(d1.name);
  print(d1.breed);
}

// 부모 클래스 - super
class Animal {
  String name;
  Animal(this.name);
  //Animal({this.name = "동물"});
}

// 이니셜라이즈 :
class Dog extends Animal {
  String breed;

  Dog(String name, this.breed) : super(name);
}

// super 라는 키워드는 부모 클래스의 생성자나 메서드를 호출할 때 사용할 수 있다.
