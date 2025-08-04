import 'dart:math';

import 'package:flutter/material.dart';

//

class CustomContainer extends StatefulWidget {
  final String name;
  const CustomContainer(this.name, {super.key});

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  late Color color = getRandomColor();
  // 부모 위젯에 멤버, 메서드에 접근하는 방법은 내부적으로 widget 변수가
  // 설계 되어 있다.
  @override
  Widget build(BuildContext context) {
    print("${widget.name} - 에 build() 메서드가 호출 됨");
    return Container(
      height: 150,
      width: 150,
      color: color,
      child: Center(
        child: Text(
          widget.name,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
        ),
      ),
    );
  }

  Color getRandomColor() {
    final Random random = Random();
    //  255 -> 0 ~ 254
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }
}
