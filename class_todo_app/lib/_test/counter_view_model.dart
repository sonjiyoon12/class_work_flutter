import 'package:class_todo_app/_test/counter.dart';

class CounterViewModel {
  Counter counter = Counter(count: 0);

  void addCounter() {
    counter.count++;
  }

  void decCounter() {
    if (counter.count > 0) {
      counter.count--;
    }
  }
}
