import 'package:flutter/material.dart';

// 코드의 진입점
void main() {
  // runApp 함수는 괄호 안에 들어가는 위젯을 루트 위젯으로 만들어 준다.
  runApp(MyApp());
}

// StatelessWidget 상태가 없는 위젯
class MyApp extends StatelessWidget {
  // const 좀 더 성능상 좋다
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 머터리얼 앱을 호출 (내부에 편리한 기능들이 너무 많이 있음)
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StorePage(),
    );
  }
} // end of MyApp

// stl 자동 완성 해보기
class StorePage extends StatelessWidget {
  const StorePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 시각적 레이아웃 틀을 잡아 주는 컴포넌트 위젯이다.
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  Text('Woman', style: TextStyle(fontWeight: FontWeight.bold)),
                  Spacer(),
                  Text('Kids', style: TextStyle(fontWeight: FontWeight.bold)),
                  Spacer(),
                  Text('Shoes', style: TextStyle(fontWeight: FontWeight.bold)),
                  Spacer(),
                  Text('Bag', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Expanded(
                child:
                    Image.asset("assets/images/bag.jpeg", fit: BoxFit.cover)),
            const SizedBox(height: 2),
            Expanded(
                child:
                    Image.asset("assets/images/cloth.jpeg", fit: BoxFit.cover)),
          ],
        ),
      ),
    );
  }
}
