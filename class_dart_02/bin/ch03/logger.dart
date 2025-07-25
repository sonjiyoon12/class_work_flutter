// Mixin <-- 여러 클래스에서 재사용할 수 있는 기능을 제공하는 방법입니다.

mixin Logger {
  void log(String message) {
    DateTime now = DateTime.now();
    print("[${now}] ${message}");
  }
}

class UserService with Logger {
  void createUser(String name) {
    log("사용자 생성 시작 : ${name}");
    // 로직 처리
    log('사용자 생성 완료');
  }
}

void main() {
  //Logger logger = new Logger();
  UserService userService = new UserService();
  userService.createUser("홍길동");

  // 자바 인터페이스 : 구현해야 할 메서드의 명세만 제공(추상적)
  // Dart 믹스인 : 완성된 기능을 그대로 제공(구체적)
}
