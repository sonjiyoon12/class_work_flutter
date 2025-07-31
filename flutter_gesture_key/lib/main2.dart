import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: MyWidget(),
      ),
    ),
  );
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

// SingleTickerProviderStateMixin -> 애니메이션을 적절히 컨트롤 하는 녀석
class _MyWidgetState extends State<MyWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  int _count = 0;
  Color _background = Colors.blue;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      // vsync는 화면 새로고침 주기에 동기화 하여 애니메이션 성능을 최적화 합니다.
      vsync: this,
      // 애니메이션의 지속 시간을 설정합니다.
      duration: Duration(milliseconds: 500),
    );

    _animation = Tween<double>(begin: 0.5, end: 2.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn))
      ..addListener(() {
        setState(() {
          // 애니메이션을 진행할 때 마다 화면을 업데이트 합니다.
        });
      });
    // Curves.easeIn --> 부드럽게 시작, 천천히 시작해서 빠르게 끝나는 처리
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Text(
              '버튼을 누르는 횟수 : $_count',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Transform.scale(
              scale: _animation.value,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  backgroundColor: _background,
                ),
                onPressed: _incrementCounter,
                child: Text(
                  '눌러보기',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _incrementCounter() {
    setState(() {
      _count++;
      _background = _colorRandom();
    });

    // 애니메이션을 앞으로 진행한 후, 완료되면 다시 원 상태로 처리
    _controller.forward().then(
      (value) {
        _controller.reverse();
      },
    );
  }

  // 추가로 랜덤한 색상을 뽑아내는 함수를 만들어서 적용!
  Color _colorRandom() {
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(255),
      random.nextInt(255),
      random.nextInt(255),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // 자원 해제
    super.dispose();
  }
}
